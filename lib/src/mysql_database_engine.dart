import 'dart:async';
import 'dart:developer';

import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_mysql/src/comman_adapters/aggregator_command_adapter_mysql.dart';
import 'package:maxi_library_db_mysql/src/comman_adapters/create_table_adapter_mysql.dart';
import 'package:maxi_library_db_mysql/src/comman_adapters/delete_command_adapter_mysql.dart';
import 'package:maxi_library_db_mysql/src/comman_adapters/modifier_command_adapter_mysql.dart';
import 'package:maxi_library_db_mysql/src/comman_adapters/query_command_adapter_mysql.dart';
import 'package:maxi_library_db_mysql/src/mysql_command_package.dart';
import 'package:maxi_library_db_mysql/src/reflection/reflection_implementation.dart';
import 'package:mysql_client/mysql_client.dart';

@reflectByMaxiLibraryDbMysql
class MysqlDatabaseEngine extends DataBaseEngineTemplate with IMultiDatabaseEngine {
  final MysqlDatabaseConfiguration configuration;
  final bool connectWithDatabaseSelected;

  MysqlDatabaseEngine({required this.configuration, this.connectWithDatabaseSelected = true});

  @override
  bool get inTransaction => _inTransaction;

  MySQLConnection? _instance;
  Timer? _databaseShutdownWaiter;
  bool _inTransaction = false;

  @override
  Future<void> prepareEngine() async {
    if (_instance != null) {
      _databaseShutdownWaiter?.cancel();
      return;
    }

    await _mountInstance();
  }

  @override
  Future<void> releaseEngine() async {
    if (_inTransaction) {
      log('[DatabaseEngineMysql] DANGER! An attempt to release the database failed due to an active transaction');
      return;
    }

    if (configuration.openConnectionSeconds == 0) {
      _closeDataBase();
    } else {
      _databaseShutdownWaiter = Timer(Duration(seconds: configuration.openConnectionSeconds), _closeDataBase);
    }
  }

  Future<void> _closeDataBase() async {
    if (_inTransaction) {
      log('[DatabaseEngineMysql] DANGER! An attempt to close the database failed due to an active transaction');
      return;
    }
    _databaseShutdownWaiter = null;
    if (_instance != null) {
      await containErrorLogAsync(
          detail: () => tr('Close a MariaDB/MySQL Database'),
          function: () async {
            try {
              await _instance!.close();
            } finally {
              _instance = null;
            }
          });
    }
  }

  @override
  Future<void> createTransaction() async {
    if (_inTransaction) {
      return;
    }

    await _executePackage(package: MysqlCommandPackage(commandText: 'START TRANSACTION;'));
    _inTransaction = true;
  }

  @override
  Future<void> commitTransaction() async {
    checkProgrammingFailure(thatChecks: () => tr('The database instance is in a transaction'), result: () => _inTransaction);

    await _executePackage(package: MysqlCommandPackage(commandText: 'COMMIT;'));
    _inTransaction = false;
  }

  @override
  Future<void> rollbackTransaction() async {
    if (!_inTransaction) {
      return;
    }

    await _executePackage(package: MysqlCommandPackage(commandText: 'ROLLBACK;'));
    _inTransaction = false;
  }

  void _checkNeedDatabaseSelected() {
    if (!connectWithDatabaseSelected) {
      throw NegativeResult(
        identifier: NegativeResultCodes.contextInvalidFunctionality,
        message: tr('To proceed with the command, it is a prerequisite that a database be selected beforehand'),
      );
    }
  }

  @override
  Future<void> executeCommandDirectly({required IDataBaseCommand command}) async {
    if (command is AggregatorCommand) {
      return _executePackage(package: AggregatorCommandAdapterMysql.convertToPackage(command: command));
    }

    if (command is DeleteCommand) {
      return _executePackage(package: DeleteCommandAdapterMysql.convertToPackage(command: command));
    }

    if (command is ModifierCommand) {
      return _executePackage(package: ModifierCommandAdapterMysql.convertToPackage(command: command));
    }

    if (command is CreateTableCommand) {
      if (await checkTableExistsDirectly(tableName: command.name)) {
        throw NegativeResult(
          identifier: NegativeResultCodes.contextInvalidFunctionality,
          message: trc('The %1 table is already defined', [command.name]),
        );
      }

      return _executePackage(package: CreateTableAdapterMysql.convertToPackage(command: command));
    }

    if (command is QueryCommand) {
      throw NegativeResult(
        identifier: NegativeResultCodes.implementationFailure,
        message: tr('A query command was attempted to be executed within a direct command function'),
      );
    }

    throw NegativeResult(
      identifier: NegativeResultCodes.implementationFailure,
      message: trc('Command type %1 is unknown for the MariaDB/MySQL engine', [command.runtimeType.toString()]),
    );
  }

  @override
  Future<TableResult> executeQueryDirectly({required QueryCommand command}) {
    _checkNeedDatabaseSelected();
    return _executeQueryPackage(package: QueryCommandAdapterMysql.convertToPackage(command: command));
  }

  @override
  Future<bool> checkTableExistsDirectly({required String tableName}) async {
    _checkNeedDatabaseSelected();
    final command = MysqlCommandPackage(
      commandText: 'SELECT `table_name` FROM `information_schema`.`tables` WHERE `table_schema` = :db AND `table_name` = :ta LIMIT 1;',
      shieldedMapedValues: {'db': configuration.dataBase, 'ta': tableName},
    );

    final table = await _executeQueryPackage(package: command);
    return table.isNotEmpty;
  }

  @override
  Future<void> deleteTableDirectly({required String tableName}) async {
    if (!await checkTableExistsDirectly(tableName: tableName)) {
      return;
    }

    return await _executePackage(package: MysqlCommandPackage(commandText: 'DROP TABLE `$tableName`'));
  }

  @override
  Future<List<String>> getTableColumnsNameDirectly({required String tableName}) async {
    _checkNeedDatabaseSelected();

    if (!await checkTableExists(tableName: tableName)) {
      throw NegativeResult(
        identifier: NegativeResultCodes.nonExistent,
        message: trc('Table %1 cannot be found', [tableName]),
      );
    }

    final command = MysqlCommandPackage(
      commandText: 'SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS`  WHERE `TABLE_SCHEMA` = :db AND `TABLE_NAME` = :ta;',
      shieldedMapedValues: {'db': configuration.dataBase, 'ta': tableName},
    );

    final table = await _executeQueryPackage(package: command);
    checkProgrammingFailure(thatChecks: () => trc('Query to table %1 returned a non-empty result', [tableName]), result: () => table.isNotEmpty);
    checkProgrammingFailure(thatChecks: () => trc('Query to table %1 returned 1 column (1 == %2)', [tableName, table.columnsName.length]), result: () => table.columnsName.length == 1);

    return table.getColumnContentByPosition(position: 0).cast<String>();
  }

  @override
  serializeToDatabase(item) {
    if (item is DateTime) {
      return ConverterUtilities.toInt(value: item);
    }
    if (item is List<int>) {
      return item;
    }

    return ReflectionUtilities.primitiveClone(item);
  }

  @override
  Future<void> createDatabase({required String databaseName, bool omitIfExists = true}) async {
    if (connectWithDatabaseSelected) {
      return MysqlDatabaseEngine(configuration: configuration, connectWithDatabaseSelected: false).createDatabase(databaseName: databaseName);
    }

    if (await checkDatabaseExists(databaseName: databaseName)) {
      if (!omitIfExists) {
        throw NegativeResult(
          identifier: NegativeResultCodes.contextInvalidFunctionality,
          message: trc('The database named %1 already exist', [databaseName]),
        );
      }
      return;
    }

    await internalReserveEngine(function: () async {
      await _mountInstance();
      try {
        await _executePackage(package: MysqlCommandPackage(commandText: 'CREATE DATABASE `$databaseName`;'));
      } finally {
        await _closeDataBase();
      }
    });
  }

  @override
  Future<void> deleteDatabase({required String databaseName}) {
    if (connectWithDatabaseSelected) {
      return MysqlDatabaseEngine(configuration: configuration, connectWithDatabaseSelected: false).deleteDatabase(databaseName: databaseName);
    }

    return internalReserveEngine(function: () async {
      await _mountInstance();
      try {
        await _executePackage(package: MysqlCommandPackage(commandText: 'DROP SCHEMA IF EXISTS `$databaseName`'));
      } finally {
        await _closeDataBase();
      }
    });
  }

  @override
  Future<bool> checkDatabaseExists({required String databaseName}) {
    if (connectWithDatabaseSelected) {
      return MysqlDatabaseEngine(configuration: configuration, connectWithDatabaseSelected: false).checkDatabaseExists(databaseName: databaseName);
    }

    return internalReserveEngine(function: () async {
      await _mountInstance();
      try {
        final result = await _executeQueryPackage(
            package: MysqlCommandPackage(
          commandText: 'SELECT `SCHEMA_NAME` FROM `INFORMATION_SCHEMA`.`SCHEMATA` WHERE `SCHEMA_NAME` = :name;',
          shieldedMapedValues: {'name': databaseName},
        ));

        return result.isNotEmpty;
      } finally {
        await _closeDataBase();
      }
    });
  }

  Future<void> _executePackage({required MysqlCommandPackage package}) async {
    checkProgrammingFailure(thatChecks: () => tr('The database instance was created previously'), result: () => _instance != null);

    final (commandText, values) = package.buildCommand();
    try {
      await Future.delayed(Duration.zero); //<--- Sometimes, a close request must be processed
      if (!_instance!.connected) {
        await _instance!.connect();
      }
      await _instance!.execute(commandText, values);
    } catch (ex) {
      throw NegativeResult(
        identifier: NegativeResultCodes.externalFault,
        message: trc('A database error occurred while processing a request. The specific error message is: %1', [ex]),
      );
    }
  }

  Future<TableResult> _executeQueryPackage({required MysqlCommandPackage package}) async {
    checkProgrammingFailure(thatChecks: () => tr('The database instance was created previously'), result: () => _instance != null);

    final (commandText, values) = package.buildCommand();
    log(commandText);
    late final IResultSet result;
    try {
      await Future.delayed(Duration.zero); //<--- Sometimes, a close request must be processed
      if (!_instance!.connected) {
        await _instance!.connect();
      }

      result = await _instance!.execute(commandText, values);
    } catch (ex) {
      throw NegativeResult(
        identifier: NegativeResultCodes.externalFault,
        message: trc('A database error occurred while processing a request. The specific error message is: %1', [ex]),
      );
    }

    final table = TableResult(columnsName: result.cols.map((e) => e.name).toList());
    for (final item in result.rows) {
      table.addRow(content: item.typedAssoc());
    }

    return table;
  }

  Future<void> _mountInstance() async {
    try {
      _instance = await MySQLConnection.createConnection(
        host: configuration.host,
        port: configuration.port,
        userName: configuration.user,
        password: configuration.password,
        secure: configuration.secureConnection,
        databaseName: connectWithDatabaseSelected ? configuration.dataBase : null,
      );
    } catch (ex) {
      throw NegativeResult(
        identifier: NegativeResultCodes.externalFault,
        message: trc('An attempt was made to open an MariaDB/MySQL, but an error occurred: %1', [ex.toString()]),
        cause: ex,
      );
    }
  }
}
