import 'dart:developer';

import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_mysql/src/mysql_command_package.dart';

mixin CreateTableAdapterMysql {
  static MysqlCommandPackage convertToPackage({required CreateTableCommand command}) {
    final buffer = StringBuffer('CREATE TABLE `${command.name}` (\n');

    for (final col in command.columns) {
      buffer.write(' `${col.nameColumn}` ${_convertColumnType(col.type)} NOT NULL');
      if (col.isPrimaryKey && col.isAutoIncrement) {
        buffer.write(' AUTOINCREMENT');
      }

      buffer.write(', \n');
    }

    for (final pri in command.columns.where((x) => x.isPrimaryKey)) {
      buffer.write(' PRIMARY KEY (`${pri.nameColumn}`)\n');
    }

    for (final uni in command.columns.where((x) => x.isUniqueKey)) {
      buffer.write(' UNIQUE (`${uni.nameColumn}`)\n');
    }

    for (final pri in command.primaryKeyGroups) {
      if (pri.isEmpty) {
        continue;
      }

      buffer.write(' PRIMARY KEY (${TextUtilities.generateCommand(list: pri.map((x) => '`$x`'))})\n');
    }

    for (final uni in command.uniqueKeyGroups) {
      if (uni.isEmpty) {
        continue;
      }

      buffer.write(' UNIQUE (${TextUtilities.generateCommand(list: uni.map((x) => '`$x`'))})\n');
    }

    for (final fore in command.foreignKeys) {
      buffer.write(' FOREIGN KEY(`${fore.fieldName}`) REFERENCES `${fore.tableName}`(`${fore.referenceFieldName}`)\n');
    }

    buffer.write(');');

    log(buffer.toString());

    return MysqlCommandPackage(commandText: buffer.toString());
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
