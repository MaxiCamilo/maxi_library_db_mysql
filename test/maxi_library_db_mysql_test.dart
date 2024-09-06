@Timeout(Duration(minutes: 30))
library;

import 'dart:convert';
import 'dart:developer';

import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_mysql/maxi_library_db_mysql.dart';
import 'package:maxi_library_db_mysql/src/reflection/maxilibrarydbmysql.dart';
import 'package:test/test.dart';

void main() {
  final database = MysqlDatabaseConfiguration()
    ..dataBase = 'pruebita'
    ..user = 'root'
    ..password = 'maxi21kpo';

  group('A group of tests', () {
    setUp(() {
      ReflectionManager.defineAlbums = [maxiLibraryDbReflectors, maxiLibraryDbMysqlReflectors];
      ReflectionManager.defineAsTheMainReflector();
    });

    test('Test reflection', () {
      final jsonText = ReflectionManager.getReflectionEntity(MysqlDatabaseConfiguration).serializeToJson(value: database);
      final newObject = ReflectionManager.getReflectionEntity(MysqlDatabaseConfiguration).interpretationFromJson(rawJson: jsonText);

      log(ReflectionManager.getReflectionEntity(MysqlDatabaseConfiguration).serializeToJson(value: newObject));
    });

    test('test engine initialization', () async {
      final engine = database.generateEngine();
      await engine.createDatabase(databaseName: 'pruebita', omitIfExists: true);
    });

    test('test create table', () async {
      final engine = database.generateEngine();
      final command = CreateTableCommand(
        name: 'table_test',
        columns: [
          ColumnAttributes(
            nameColumn: 'id',
            type: ColumnAttributesType.intWithoutLimit,
            isPrimaryKey: true,
            isAutoIncrement: true,
          ),
          ColumnAttributes(
            nameColumn: 'name',
            type: ColumnAttributesType.text,
          ),
          ColumnAttributes(
            nameColumn: 'isNice',
            type: ColumnAttributesType.boolean,
          ),
        ],
        primaryKeyGroups: [],
        uniqueKeyGroups: [
          ['name']
        ],
        foreignKeys: [],
      );

      if (await engine.checkTableExists(tableName: 'table_test')) {
        await engine.deleteTable(tableName: 'table_reference_test');
        await engine.deleteTable(tableName: 'table_test');
      }

      await engine.executeCommand(command: command);

      final referenceCommand = CreateTableCommand(
        name: 'table_reference_test',
        columns: [
          ColumnAttributes(
            nameColumn: 'id_reference',
            type: ColumnAttributesType.intWithoutLimit,
          ),
          ColumnAttributes(
            nameColumn: 'reference_text',
            type: ColumnAttributesType.text,
          ),
        ],
        primaryKeyGroups: [
          ['id_reference']
        ],
        uniqueKeyGroups: [],
        foreignKeys: [
          ForeignKey(
            fieldName: 'id_reference',
            tableName: 'table_test',
            referenceFieldName: 'id',
          )
        ],
      );

      await engine.executeCommand(command: referenceCommand);
    });

    test('Add info', () async {
      final engine = database.generateEngine();

      for (int i = 1; i < 1000; i++) {
        final command = AggregatorCommand(tableName: 'table_test', dataField: {
          'id': i,
          'name': 'Value with id $i',
          'isNice': i % 2 == 0,
        });

        await engine.executeCommand(command: command);

        final referenceCommand = AggregatorCommand(tableName: 'table_reference_test', dataField: {
          'id_reference': i,
          'reference_text': 'Reference #$i',
        });

        await engine.executeCommand(command: referenceCommand);
      }
    });

    test('Generate transaction', () {
      final engine = database.generateEngine();

      return engine.executeFunctionAsTransaction(function: (x) async {
        await x.executeCommand(command: DeleteCommand(tableName: 'table_test'));

        for (int i = 1; i <= 100000; i++) {
          final command = AggregatorCommand(tableName: 'table_test', dataField: {
            'name': 'Value #$i',
            'isNice': i % 2 == 0,
          });

          await x.executeCommand(command: command);
        }

        return true;
      });
    });

    test('Test query', () async {
      final engine = database.generateEngine();

      final command = QueryCommand(
        selectedFields: [
          QueryField(fieldName: 'id', tableName: 'table_test'),
          QueryField(fieldName: 'name', tableName: 'table_test'),
          QueryField(fieldName: 'isNice', tableName: 'table_test'),
          QueryField(fieldName: 'reference_text', tableName: 'table_reference_test'),
        ],
        joinedTables: [
          QueryJoiner(
            originTable: QueryTable(fieldName: 'table_test'),
            externalTable: QueryTable(fieldName: 'table_reference_test'),
            comparers: [
              CompareFields(originField: 'id', compareField: 'id_reference'),
            ],
          ),
        ],
        selectedTables: [QueryTable(fieldName: 'table_test')],
        conditions: [
          CompareValue(originField: 'id', value: 50, typeComparation: ConditionCompareType.greaterEqual),
          CompareValue(originField: 'id', value: 57, typeComparation: ConditionCompareType.lessEqual),
          CompareIncludesValues(fieldName: 'id', options: [52, 55, 57, 59]),
        ],
        limit: 50,
      );

      final result = await engine.executeQuery(command: command);
      final jsonResult = json.encode(result.toList());
      log(jsonResult);
    });
  });
}
