// ignore_for_file: unnecessary_const, unnecessary_import, duplicate_import, unused_import

import 'package:maxi_library/export_reflectors.dart';
import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_mysql/src/mysql_command_package.dart';
import 'dart:developer';
import 'package:maxi_library_db_mysql/src/comman_adapters/condition_command_adapter_mysql.dart';
import 'package:maxi_library_db_mysql/src/comman_adapters/joiner_command_adapter_mysql.dart';
import 'dart:async';
import 'package:maxi_library_db_mysql/maxi_library_db_mysql.dart';
import 'package:maxi_library_db_mysql/src/comman_adapters/aggregator_command_adapter_mysql.dart';
import 'package:maxi_library_db_mysql/src/comman_adapters/create_table_adapter_mysql.dart';
import 'package:maxi_library_db_mysql/src/comman_adapters/delete_command_adapter_mysql.dart';
import 'package:maxi_library_db_mysql/src/comman_adapters/modifier_command_adapter_mysql.dart';
import 'package:maxi_library_db_mysql/src/comman_adapters/query_command_adapter_mysql.dart';
import 'package:maxi_library_db_mysql/src/test/person.dart';
import 'package:mysql_client/mysql_client.dart';



/*----------------------------------   Class MysqlDatabaseEngine   ----------------------------------*/


/*MYSQLDATABASEENGINE FIELDS*/

class _MysqlDatabaseEngineconfiguration extends GeneratedReflectedField<MysqlDatabaseEngine,MysqlDatabaseConfiguration>{
const _MysqlDatabaseEngineconfiguration();
@override
List get annotations => const [];

@override
String get name => 'configuration';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => true;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => false;
@override
MysqlDatabaseConfiguration? get defaulValue => null;

@override
MysqlDatabaseConfiguration getReservedValue({required MysqlDatabaseEngine? entity}) =>
entity!.configuration;
}

class _MysqlDatabaseEngineconnectWithDatabaseSelected extends GeneratedReflectedField<MysqlDatabaseEngine,bool>{
const _MysqlDatabaseEngineconnectWithDatabaseSelected();
@override
List get annotations => const [];

@override
String get name => 'connectWithDatabaseSelected';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => true;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => false;
@override
bool? get defaulValue => null;

@override
bool getReservedValue({required MysqlDatabaseEngine? entity}) =>
entity!.connectWithDatabaseSelected;
}

/*MYSQLDATABASEENGINE METHODS*/

class _MysqlDatabaseEngineinTransactionGetter extends GeneratedReflectedMethod<MysqlDatabaseEngine, bool> {
const _MysqlDatabaseEngineinTransactionGetter();
@override
String get name => 'inTransaction';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.getMehtod;

@override
List get annotations => const [override];

@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
bool callReservedMethod({required MysqlDatabaseEngine? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.inTransaction;
}


class _MysqlDatabaseEngineprepareEngineMethod extends GeneratedReflectedMethod<MysqlDatabaseEngine, Future<void>> {
const _MysqlDatabaseEngineprepareEngineMethod();
@override
String get name => 'prepareEngine';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
Future<void> callReservedMethod({required MysqlDatabaseEngine? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.prepareEngine();
}


class _MysqlDatabaseEnginereleaseEngineMethod extends GeneratedReflectedMethod<MysqlDatabaseEngine, Future<void>> {
const _MysqlDatabaseEnginereleaseEngineMethod();
@override
String get name => 'releaseEngine';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
Future<void> callReservedMethod({required MysqlDatabaseEngine? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.releaseEngine();
}


class _MysqlDatabaseEnginecreateTransactionMethod extends GeneratedReflectedMethod<MysqlDatabaseEngine, Future<void>> {
const _MysqlDatabaseEnginecreateTransactionMethod();
@override
String get name => 'createTransaction';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
Future<void> callReservedMethod({required MysqlDatabaseEngine? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.createTransaction();
}


class _MysqlDatabaseEnginecommitTransactionMethod extends GeneratedReflectedMethod<MysqlDatabaseEngine, Future<void>> {
const _MysqlDatabaseEnginecommitTransactionMethod();
@override
String get name => 'commitTransaction';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
Future<void> callReservedMethod({required MysqlDatabaseEngine? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.commitTransaction();
}


class _MysqlDatabaseEnginerollbackTransactionMethod extends GeneratedReflectedMethod<MysqlDatabaseEngine, Future<void>> {
const _MysqlDatabaseEnginerollbackTransactionMethod();
@override
String get name => 'rollbackTransaction';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
Future<void> callReservedMethod({required MysqlDatabaseEngine? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.rollbackTransaction();
}


class _MysqlDatabaseEngineexecuteCommandDirectlyMethod extends GeneratedReflectedMethod<MysqlDatabaseEngine, Future<void>> {
const _MysqlDatabaseEngineexecuteCommandDirectlyMethod();
@override
String get name => 'executeCommandDirectly';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

static const _namcommand = GeneratedReflectedNamedParameter<IDataBaseCommand>(
      annotations: const [],
      defaultValue: null,
      hasDefaultValue: false,
      acceptNulls: false,
      name: 'command',
)
;@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [_namcommand];

@override
Future<void> callReservedMethod({required MysqlDatabaseEngine? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.executeCommandDirectly(command: _namcommand.getValueFromMap(namedValues),);
}


class _MysqlDatabaseEngineexecuteQueryDirectlyMethod extends GeneratedReflectedMethod<MysqlDatabaseEngine, Future<TableResult>> {
const _MysqlDatabaseEngineexecuteQueryDirectlyMethod();
@override
String get name => 'executeQueryDirectly';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

static const _namcommand = GeneratedReflectedNamedParameter<QueryCommand>(
      annotations: const [],
      defaultValue: null,
      hasDefaultValue: false,
      acceptNulls: false,
      name: 'command',
)
;@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [_namcommand];

@override
Future<TableResult> callReservedMethod({required MysqlDatabaseEngine? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.executeQueryDirectly(command: _namcommand.getValueFromMap(namedValues),);
}


class _MysqlDatabaseEnginecheckTableExistsDirectlyMethod extends GeneratedReflectedMethod<MysqlDatabaseEngine, Future<bool>> {
const _MysqlDatabaseEnginecheckTableExistsDirectlyMethod();
@override
String get name => 'checkTableExistsDirectly';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

static const _namtableName = GeneratedReflectedNamedParameter<String>(
      annotations: const [],
      defaultValue: null,
      hasDefaultValue: false,
      acceptNulls: false,
      name: 'tableName',
)
;@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [_namtableName];

@override
Future<bool> callReservedMethod({required MysqlDatabaseEngine? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.checkTableExistsDirectly(tableName: _namtableName.getValueFromMap(namedValues),);
}


class _MysqlDatabaseEnginedeleteTableDirectlyMethod extends GeneratedReflectedMethod<MysqlDatabaseEngine, Future<void>> {
const _MysqlDatabaseEnginedeleteTableDirectlyMethod();
@override
String get name => 'deleteTableDirectly';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

static const _namtableName = GeneratedReflectedNamedParameter<String>(
      annotations: const [],
      defaultValue: null,
      hasDefaultValue: false,
      acceptNulls: false,
      name: 'tableName',
)
;@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [_namtableName];

@override
Future<void> callReservedMethod({required MysqlDatabaseEngine? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.deleteTableDirectly(tableName: _namtableName.getValueFromMap(namedValues),);
}


class _MysqlDatabaseEnginegetTableColumnsNameDirectlyMethod extends GeneratedReflectedMethod<MysqlDatabaseEngine, Future<List<String>>> {
const _MysqlDatabaseEnginegetTableColumnsNameDirectlyMethod();
@override
String get name => 'getTableColumnsNameDirectly';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

static const _namtableName = GeneratedReflectedNamedParameter<String>(
      annotations: const [],
      defaultValue: null,
      hasDefaultValue: false,
      acceptNulls: false,
      name: 'tableName',
)
;@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [_namtableName];

@override
Future<List<String>> callReservedMethod({required MysqlDatabaseEngine? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.getTableColumnsNameDirectly(tableName: _namtableName.getValueFromMap(namedValues),);
}


class _MysqlDatabaseEngineserializeToDatabaseMethod extends GeneratedReflectedMethod<MysqlDatabaseEngine, dynamic> {
const _MysqlDatabaseEngineserializeToDatabaseMethod();
@override
String get name => 'serializeToDatabase';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

static const _fix0 = GeneratedReflectedFixedParameter<dynamic>(
      annotations: const [],
      name: 'item',
      position: 0,
      hasDefaultValue: false,
      defaultValue: null,
      acceptNulls: false,
    )
;
@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [_fix0];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
dynamic callReservedMethod({required MysqlDatabaseEngine? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.serializeToDatabase(_fix0.getValueFromList(fixedValues),);
}


class _MysqlDatabaseEnginecreateDatabaseMethod extends GeneratedReflectedMethod<MysqlDatabaseEngine, Future<void>> {
const _MysqlDatabaseEnginecreateDatabaseMethod();
@override
String get name => 'createDatabase';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

static const _namdatabaseName = GeneratedReflectedNamedParameter<String>(
      annotations: const [],
      defaultValue: null,
      hasDefaultValue: false,
      acceptNulls: false,
      name: 'databaseName',
)
;static const _namomitIfExists = GeneratedReflectedNamedParameter<bool>(
      annotations: const [],
      defaultValue: true,
      hasDefaultValue: true,
      acceptNulls: false,
      name: 'omitIfExists',
)
;@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [_namdatabaseName,_namomitIfExists];

@override
Future<void> callReservedMethod({required MysqlDatabaseEngine? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.createDatabase(databaseName: _namdatabaseName.getValueFromMap(namedValues),omitIfExists: _namomitIfExists.getValueFromMap(namedValues),);
}


class _MysqlDatabaseEnginedeleteDatabaseMethod extends GeneratedReflectedMethod<MysqlDatabaseEngine, Future<void>> {
const _MysqlDatabaseEnginedeleteDatabaseMethod();
@override
String get name => 'deleteDatabase';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

static const _namdatabaseName = GeneratedReflectedNamedParameter<String>(
      annotations: const [],
      defaultValue: null,
      hasDefaultValue: false,
      acceptNulls: false,
      name: 'databaseName',
)
;@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [_namdatabaseName];

@override
Future<void> callReservedMethod({required MysqlDatabaseEngine? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.deleteDatabase(databaseName: _namdatabaseName.getValueFromMap(namedValues),);
}


class _MysqlDatabaseEnginecheckDatabaseExistsMethod extends GeneratedReflectedMethod<MysqlDatabaseEngine, Future<bool>> {
const _MysqlDatabaseEnginecheckDatabaseExistsMethod();
@override
String get name => 'checkDatabaseExists';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

static const _namdatabaseName = GeneratedReflectedNamedParameter<String>(
      annotations: const [],
      defaultValue: null,
      hasDefaultValue: false,
      acceptNulls: false,
      name: 'databaseName',
)
;@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [_namdatabaseName];

@override
Future<bool> callReservedMethod({required MysqlDatabaseEngine? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.checkDatabaseExists(databaseName: _namdatabaseName.getValueFromMap(namedValues),);
}


class _MysqlDatabaseEngineBuilder extends GeneratedReflectedMethod<MysqlDatabaseEngine, MysqlDatabaseEngine> {
const _MysqlDatabaseEngineBuilder();
@override
String get name => '';

@override
bool get isStatic => true;

@override
MethodDetectedType get methodType => MethodDetectedType.buildMethod;

@override
List get annotations => const [];

static const _namconfiguration = GeneratedReflectedNamedParameter<dynamic>(
      annotations: const [],
      defaultValue: null,
      hasDefaultValue: false,
      acceptNulls: false,
      name: 'configuration',
)
;static const _namconnectWithDatabaseSelected = GeneratedReflectedNamedParameter<dynamic>(
      annotations: const [],
      defaultValue: true,
      hasDefaultValue: true,
      acceptNulls: false,
      name: 'connectWithDatabaseSelected',
)
;@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [_namconfiguration,_namconnectWithDatabaseSelected];

@override
MysqlDatabaseEngine callReservedMethod({required MysqlDatabaseEngine? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
MysqlDatabaseEngine(configuration: _namconfiguration.getValueFromMap(namedValues),connectWithDatabaseSelected: _namconnectWithDatabaseSelected.getValueFromMap(namedValues),);
}


/*MYSQLDATABASEENGINE INSTANCE*/

class _MysqlDatabaseEngine extends GeneratedReflectedClass<MysqlDatabaseEngine> {
const _MysqlDatabaseEngine();
@override
List get annotations => const [reflect];

@override
Type? get baseClass => DataBaseEngineTemplate;

@override
List<Type> get classThatImplement => const [IMultiDatabaseEngine];

@override
bool get isAbstract => false;

@override
bool get isMixin => false;

@override
String get name => 'MysqlDatabaseEngine';

@override
List<GeneratedReflectedMethod> get methods => const [_MysqlDatabaseEngineinTransactionGetter(),_MysqlDatabaseEngineprepareEngineMethod(),_MysqlDatabaseEnginereleaseEngineMethod(),_MysqlDatabaseEnginecreateTransactionMethod(),_MysqlDatabaseEnginecommitTransactionMethod(),_MysqlDatabaseEnginerollbackTransactionMethod(),_MysqlDatabaseEngineexecuteCommandDirectlyMethod(),_MysqlDatabaseEngineexecuteQueryDirectlyMethod(),_MysqlDatabaseEnginecheckTableExistsDirectlyMethod(),_MysqlDatabaseEnginedeleteTableDirectlyMethod(),_MysqlDatabaseEnginegetTableColumnsNameDirectlyMethod(),_MysqlDatabaseEngineserializeToDatabaseMethod(),_MysqlDatabaseEnginecreateDatabaseMethod(),_MysqlDatabaseEnginedeleteDatabaseMethod(),_MysqlDatabaseEnginecheckDatabaseExistsMethod(),_MysqlDatabaseEngineBuilder()];

@override
List<GeneratedReflectedField> get fields => const [_MysqlDatabaseEngineconfiguration(),_MysqlDatabaseEngineconnectWithDatabaseSelected()];


}
/*----------------------------------   x   ----------------------------------*/



/*----------------------------------   Class MysqlDatabaseConfiguration   ----------------------------------*/


/*MYSQLDATABASECONFIGURATION FIELDS*/

class _MysqlDatabaseConfigurationhost extends GeneratedReflectedField<MysqlDatabaseConfiguration,String> with GeneratedReflectedModifiableField<MysqlDatabaseConfiguration,String> {
const _MysqlDatabaseConfigurationhost();
@override
List get annotations => const [CheckIp()];

@override
String get name => 'host';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => false;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => true;
@override
String? get defaulValue => '127.0.0.1';

@override
String getReservedValue({required MysqlDatabaseConfiguration? entity}) =>
entity!.host;
@override
void setReservedValue({required MysqlDatabaseConfiguration? entity, required String newValue}) =>
	entity!.host = newValue;
}

class _MysqlDatabaseConfigurationport extends GeneratedReflectedField<MysqlDatabaseConfiguration,int> with GeneratedReflectedModifiableField<MysqlDatabaseConfiguration,int> {
const _MysqlDatabaseConfigurationport();
@override
List get annotations => const [CheckIpPort(acceptZero: false)];

@override
String get name => 'port';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => false;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => true;
@override
int? get defaulValue => 3306;

@override
int getReservedValue({required MysqlDatabaseConfiguration? entity}) =>
entity!.port;
@override
void setReservedValue({required MysqlDatabaseConfiguration? entity, required int newValue}) =>
	entity!.port = newValue;
}

class _MysqlDatabaseConfigurationuser extends GeneratedReflectedField<MysqlDatabaseConfiguration,String> with GeneratedReflectedModifiableField<MysqlDatabaseConfiguration,String> {
const _MysqlDatabaseConfigurationuser();
@override
List get annotations => const [CheckTextLength(minimum: 1, maximum: 120)];

@override
String get name => 'user';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => false;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => true;
@override
String? get defaulValue => '';

@override
String getReservedValue({required MysqlDatabaseConfiguration? entity}) =>
entity!.user;
@override
void setReservedValue({required MysqlDatabaseConfiguration? entity, required String newValue}) =>
	entity!.user = newValue;
}

class _MysqlDatabaseConfigurationpassword extends GeneratedReflectedField<MysqlDatabaseConfiguration,String> with GeneratedReflectedModifiableField<MysqlDatabaseConfiguration,String> {
const _MysqlDatabaseConfigurationpassword();
@override
List get annotations => const [CheckTextLength(minimum: 0, maximum: 256)];

@override
String get name => 'password';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => false;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => true;
@override
String? get defaulValue => '';

@override
String getReservedValue({required MysqlDatabaseConfiguration? entity}) =>
entity!.password;
@override
void setReservedValue({required MysqlDatabaseConfiguration? entity, required String newValue}) =>
	entity!.password = newValue;
}

class _MysqlDatabaseConfigurationdataBase extends GeneratedReflectedField<MysqlDatabaseConfiguration,String> with GeneratedReflectedModifiableField<MysqlDatabaseConfiguration,String> {
const _MysqlDatabaseConfigurationdataBase();
@override
List get annotations => const [CheckTextLength(minimum: 1, maximum: 120)];

@override
String get name => 'dataBase';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => false;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => true;
@override
String? get defaulValue => '';

@override
String getReservedValue({required MysqlDatabaseConfiguration? entity}) =>
entity!.dataBase;
@override
void setReservedValue({required MysqlDatabaseConfiguration? entity, required String newValue}) =>
	entity!.dataBase = newValue;
}

class _MysqlDatabaseConfigurationmaxActiveConnections extends GeneratedReflectedField<MysqlDatabaseConfiguration,int> with GeneratedReflectedModifiableField<MysqlDatabaseConfiguration,int> {
const _MysqlDatabaseConfigurationmaxActiveConnections();
@override
List get annotations => const [CheckNumberRange(minimum: 1, maximum: 256)];

@override
String get name => 'maxActiveConnections';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => false;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => true;
@override
int? get defaulValue => 30;

@override
int getReservedValue({required MysqlDatabaseConfiguration? entity}) =>
entity!.maxActiveConnections;
@override
void setReservedValue({required MysqlDatabaseConfiguration? entity, required int newValue}) =>
	entity!.maxActiveConnections = newValue;
}

class _MysqlDatabaseConfigurationsecureConnection extends GeneratedReflectedField<MysqlDatabaseConfiguration,bool> with GeneratedReflectedModifiableField<MysqlDatabaseConfiguration,bool> {
const _MysqlDatabaseConfigurationsecureConnection();
@override
List get annotations => const [];

@override
String get name => 'secureConnection';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => false;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => true;
@override
bool? get defaulValue => false;

@override
bool getReservedValue({required MysqlDatabaseConfiguration? entity}) =>
entity!.secureConnection;
@override
void setReservedValue({required MysqlDatabaseConfiguration? entity, required bool newValue}) =>
	entity!.secureConnection = newValue;
}

class _MysqlDatabaseConfigurationmillisecondsInTimeout extends GeneratedReflectedField<MysqlDatabaseConfiguration,int> with GeneratedReflectedModifiableField<MysqlDatabaseConfiguration,int> {
const _MysqlDatabaseConfigurationmillisecondsInTimeout();
@override
List get annotations => const [CheckNumberRange(minimum: 1000, maximum: 60000)];

@override
String get name => 'millisecondsInTimeout';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => false;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => true;
@override
int? get defaulValue => 7500;

@override
int getReservedValue({required MysqlDatabaseConfiguration? entity}) =>
entity!.millisecondsInTimeout;
@override
void setReservedValue({required MysqlDatabaseConfiguration? entity, required int newValue}) =>
	entity!.millisecondsInTimeout = newValue;
}

class _MysqlDatabaseConfigurationopenConnectionSeconds extends GeneratedReflectedField<MysqlDatabaseConfiguration,int> with GeneratedReflectedModifiableField<MysqlDatabaseConfiguration,int> {
const _MysqlDatabaseConfigurationopenConnectionSeconds();
@override
List get annotations => const [CheckNumberRange(minimum: 0)];

@override
String get name => 'openConnectionSeconds';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => false;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => true;
@override
int? get defaulValue => 30;

@override
int getReservedValue({required MysqlDatabaseConfiguration? entity}) =>
entity!.openConnectionSeconds;
@override
void setReservedValue({required MysqlDatabaseConfiguration? entity, required int newValue}) =>
	entity!.openConnectionSeconds = newValue;
}

/*MYSQLDATABASECONFIGURATION METHODS*/

class _MysqlDatabaseConfigurationgenerateEngineMethod extends GeneratedReflectedMethod<MysqlDatabaseConfiguration, MysqlDatabaseEngine> {
const _MysqlDatabaseConfigurationgenerateEngineMethod();
@override
String get name => 'generateEngine';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
MysqlDatabaseEngine callReservedMethod({required MysqlDatabaseConfiguration? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.generateEngine();
}


class _MysqlDatabaseConfigurationgenerateEngineWithoutAssignedDatabaseMethod extends GeneratedReflectedMethod<MysqlDatabaseConfiguration, MysqlDatabaseEngine> {
const _MysqlDatabaseConfigurationgenerateEngineWithoutAssignedDatabaseMethod();
@override
String get name => 'generateEngineWithoutAssignedDatabase';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [];

@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
MysqlDatabaseEngine callReservedMethod({required MysqlDatabaseConfiguration? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.generateEngineWithoutAssignedDatabase();
}


class _MysqlDatabaseConfigurationBuilder extends GeneratedReflectedMethod<MysqlDatabaseConfiguration, MysqlDatabaseConfiguration> {
const _MysqlDatabaseConfigurationBuilder();
@override
String get name => '';

@override
bool get isStatic => true;

@override
MethodDetectedType get methodType => MethodDetectedType.buildMethod;

@override
List get annotations => const [];

@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
MysqlDatabaseConfiguration callReservedMethod({required MysqlDatabaseConfiguration? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
MysqlDatabaseConfiguration();
}


/*MYSQLDATABASECONFIGURATION INSTANCE*/

class _MysqlDatabaseConfiguration extends GeneratedReflectedClass<MysqlDatabaseConfiguration> {
const _MysqlDatabaseConfiguration();
@override
List get annotations => const [reflect];

@override
Type? get baseClass => null;

@override
List<Type> get classThatImplement => const [IDataBaseConfiguration];

@override
bool get isAbstract => false;

@override
bool get isMixin => false;

@override
String get name => 'MysqlDatabaseConfiguration';

@override
List<GeneratedReflectedMethod> get methods => const [_MysqlDatabaseConfigurationgenerateEngineMethod(),_MysqlDatabaseConfigurationgenerateEngineWithoutAssignedDatabaseMethod(),_MysqlDatabaseConfigurationBuilder()];

@override
List<GeneratedReflectedField> get fields => const [_MysqlDatabaseConfigurationhost(),_MysqlDatabaseConfigurationport(),_MysqlDatabaseConfigurationuser(),_MysqlDatabaseConfigurationpassword(),_MysqlDatabaseConfigurationdataBase(),_MysqlDatabaseConfigurationmaxActiveConnections(),_MysqlDatabaseConfigurationsecureConnection(),_MysqlDatabaseConfigurationmillisecondsInTimeout(),_MysqlDatabaseConfigurationopenConnectionSeconds()];


}
/*----------------------------------   x   ----------------------------------*/



/*----------------------------------   Class Person   ----------------------------------*/


/*PERSON FIELDS*/

class _Personidentifier extends GeneratedReflectedField<Person,int> with GeneratedReflectedModifiableField<Person,int> {
const _Personidentifier();
@override
List get annotations => const [PrimaryKey(),CheckNumberRange(minimum: 0, maximum: 999)];

@override
String get name => 'identifier';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => false;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => true;
@override
int? get defaulValue => 0;

@override
int getReservedValue({required Person? entity}) =>
entity!.identifier;
@override
void setReservedValue({required Person? entity, required int newValue}) =>
	entity!.identifier = newValue;
}

class _Personname extends GeneratedReflectedField<Person,String> with GeneratedReflectedModifiableField<Person,String> {
const _Personname();
@override
List get annotations => const [CheckTextLength(minimum: 3, maximum: 99)];

@override
String get name => 'name';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => false;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => true;
@override
String? get defaulValue => '';

@override
String getReservedValue({required Person? entity}) =>
entity!.name;
@override
void setReservedValue({required Person? entity, required String newValue}) =>
	entity!.name = newValue;
}

class _Personage extends GeneratedReflectedField<Person,int> with GeneratedReflectedModifiableField<Person,int> {
const _Personage();
@override
List get annotations => const [CheckNumberRange(minimum: 18, maximum: 99)];

@override
String get name => 'age';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => false;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => true;
@override
int? get defaulValue => 0;

@override
int getReservedValue({required Person? entity}) =>
entity!.age;
@override
void setReservedValue({required Person? entity, required int newValue}) =>
	entity!.age = newValue;
}

class _Personsalary extends GeneratedReflectedField<Person,double> with GeneratedReflectedModifiableField<Person,double> {
const _Personsalary();
@override
List get annotations => const [CheckNumberRange(maximum: 99999)];

@override
String get name => 'salary';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => false;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => true;
@override
double? get defaulValue => 0;

@override
double getReservedValue({required Person? entity}) =>
entity!.salary;
@override
void setReservedValue({required Person? entity, required double newValue}) =>
	entity!.salary = newValue;
}

class _PersonisBoss extends GeneratedReflectedField<Person,bool> with GeneratedReflectedModifiableField<Person,bool> {
const _PersonisBoss();
@override
List get annotations => const [FormalName('is he an idiot?')];

@override
String get name => 'isBoss';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => false;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => true;
@override
bool? get defaulValue => false;

@override
bool getReservedValue({required Person? entity}) =>
entity!.isBoss;
@override
void setReservedValue({required Person? entity, required bool newValue}) =>
	entity!.isBoss = newValue;
}

/*PERSON METHODS*/

class _PersonBuilder extends GeneratedReflectedMethod<Person, Person> {
const _PersonBuilder();
@override
String get name => '';

@override
bool get isStatic => true;

@override
MethodDetectedType get methodType => MethodDetectedType.buildMethod;

@override
List get annotations => const [];

@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
Person callReservedMethod({required Person? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
Person();
}


/*PERSON INSTANCE*/

class _Person extends GeneratedReflectedClass<Person> {
const _Person();
@override
List get annotations => const [reflect];

@override
Type? get baseClass => null;

@override
List<Type> get classThatImplement => const [];

@override
bool get isAbstract => false;

@override
bool get isMixin => false;

@override
String get name => 'Person';

@override
List<GeneratedReflectedMethod> get methods => const [_PersonBuilder()];

@override
List<GeneratedReflectedField> get fields => const [_Personidentifier(),_Personname(),_Personage(),_Personsalary(),_PersonisBoss()];


}
/*----------------------------------   x   ----------------------------------*/



class _AlbumMaxiLibraryDbMysql extends GeneratedReflectorAlbum {
  const _AlbumMaxiLibraryDbMysql();
  @override
  List<GeneratedReflectedClass> get classes => const [_MysqlDatabaseEngine(),_MysqlDatabaseConfiguration(),_Person()];

  @override
  List<TypeEnumeratorReflector> get enums => const [];
}


const maxiLibraryDbMysqlReflectors = _AlbumMaxiLibraryDbMysql();
