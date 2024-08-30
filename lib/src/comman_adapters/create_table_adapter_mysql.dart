import 'dart:developer';

import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_mysql/src/mysql_command_package.dart';

mixin CreateTableAdapterMysql {
  static MysqlCommandPackage convertToPackage({required CreateTableCommand command}) {
    String commandText = 'CREATE TABLE `${command.name}` (\n';
    final parts = <String>[];

    for (final col in command.columns) {
      String text = ' `${col.nameColumn}` ${_convertColumnType(col.type)} NOT NULL';
      if (col.isPrimaryKey && col.isAutoIncrement) {
        text += ' AUTO_INCREMENT';
      }

      parts.add(text);
    }

    for (final pri in command.columns.where((x) => x.isPrimaryKey)) {
      parts.add(' PRIMARY KEY (`${pri.nameColumn}`)');
    }

    for (final uni in command.columns.where((x) => x.isUniqueKey)) {
      parts.add(' UNIQUE (`${uni.nameColumn}`)');
    }

    for (final pri in command.primaryKeyGroups) {
      if (pri.isEmpty) {
        continue;
      }

      parts.add(' PRIMARY KEY (${TextUtilities.generateCommand(list: pri.map((x) => '`$x`'))})');
    }

    for (final uni in command.uniqueKeyGroups) {
      if (uni.isEmpty) {
        continue;
      }

      parts.add(' UNIQUE (${TextUtilities.generateCommand(list: uni.map((x) => '`$x`'))})');
    }

    for (final fore in command.foreignKeys) {
      parts.add(' FOREIGN KEY(`${fore.fieldName}`) REFERENCES `${fore.tableName}`(`${fore.referenceFieldName}`)\n');
    }

    commandText += TextUtilities.generateCommand(list: parts, character: ',\n');
    commandText += ');';

    log(commandText);

    return MysqlCommandPackage(commandText: commandText);
  }

  static String _convertColumnType(ColumnAttributesType type) {
    return switch (type) {
      ColumnAttributesType.text => 'TEXT',
      ColumnAttributesType.boolean => 'BOOL',
      ColumnAttributesType.intWithoutLimit => 'INTEGER',
      ColumnAttributesType.int8 => 'TINYINT',
      ColumnAttributesType.int16 => 'SMALLINT',
      ColumnAttributesType.int32 => 'INT',
      ColumnAttributesType.int64 => 'BIGINT',
      ColumnAttributesType.uintWithoutLimit => 'INTEGER',
      ColumnAttributesType.uint8 => 'TINYINT UNSIGNED',
      ColumnAttributesType.uint16 => 'SMALLINT UNSIGNED',
      ColumnAttributesType.uint32 => 'INT UNSIGNED',
      ColumnAttributesType.uint64 => 'BIGINT UNSIGNED',
      ColumnAttributesType.doubleWithoutLimit => 'DOUBLE',
      ColumnAttributesType.decimal => 'DECIMAL',
      ColumnAttributesType.dateTime => 'BIGINT UNSIGNED',
      ColumnAttributesType.binary => 'BLOB',
      ColumnAttributesType.dynamicType => 'BLOB',
    };
  }
}
