import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_mysql/src/comman_adapters/condition_command_adapter_mysql.dart';
import 'package:maxi_library_db_mysql/src/comman_adapters/joiner_command_adapter_mysql.dart';
import 'package:maxi_library_db_mysql/src/mysql_command_package.dart';

mixin QueryCommandAdapterMysql {
  static MysqlCommandPackage convertToPackage({required QueryCommand command}) {
    final buffer = StringBuffer();
    final shieldedFixedValues = [];
    final shieldedNamedValues = <String, dynamic>{};

    buffer.write('SELECT ');

    if (command.selectedFields.isEmpty) {
      buffer.write('*');
    } else {
      _convertSelectFields(command, buffer);
    }

    buffer.write('\n FROM ');
    _convertSelectedTable(command, buffer);

    for (final joined in command.joinedTables) {
      buffer.write('\n ${JoinerCommandAdapterMysql.convertJoiner(command: joined)}');
    }

    if (command.conditions.isNotEmpty) {
      buffer.write('\n WHERE ');
      _convertConditions(command, buffer, shieldedFixedValues, shieldedNamedValues);
    }

    if (command.grouped.isNotEmpty) {
      buffer.write('\n GROUP BY ${TextUtilities.generateCommand(list: command.grouped.map((x) => '"$x"'))} ');
    }

    if (command.havings.isNotEmpty) {
      buffer.write('\n HAVING ');
      _convertHavings(command, buffer, shieldedFixedValues, shieldedNamedValues);
    }

    if (command.orders.isNotEmpty) {
      _convertOrderBy(command, buffer);
    }

    if (command.limit != null && command.limit! > 0) {
      buffer.write('\n LIMIT ${command.limit}');
    }

    buffer.write(';');

    return MysqlCommandPackage(
      commandText: buffer.toString(),
      shieldedFixedValues: shieldedFixedValues,
      shieldedMapedValues: shieldedNamedValues,
    );
  }

  static void _convertSelectFields(QueryCommand command, StringBuffer buffer) {
    final textsCommands = <String>[];
    for (final field in command.selectedFields) {
      late String text;
      if (field.fieldName == '') {
        text = '*';
      } else {
        text = '`${field.fieldName}`';
      }

      switch (field.type) {
        case QueryFieldType.field:
          break;
        case QueryFieldType.count:
          text = 'COUNT($text)';
          break;
        case QueryFieldType.maximum:
          text = 'MAX($text)';
          break;
        case QueryFieldType.minimum:
          text = 'MIN($text)';
          break;
        case QueryFieldType.sum:
          text = 'SUM($text)';
          break;
        case QueryFieldType.average:
          text = 'AVG($text)';
          break;
      }

      if (field.nickName != '') {
        text = '$text AS `${field.nickName}`';
      }

      textsCommands.add(text);
    }

    buffer.write(TextUtilities.generateCommand(list: textsCommands));
  }

  static void _convertSelectedTable(QueryCommand command, StringBuffer buffer) {
    final textsCommands = <String>[];

    for (final table in command.selectedTables) {
      if (table.nickName.isEmpty) {
        textsCommands.add('`${table.fieldName}`');
      } else {
        textsCommands.add('`${table.fieldName}` AS `${table.nickName}`');
      }
    }

    buffer.write(TextUtilities.generateCommand(list: textsCommands));
  }

  static void _convertConditions(QueryCommand command, StringBuffer buffer, List shieldedFixedValues, Map<String, dynamic> shieldedNamedValues) {
    final textsCommands = <String>[];
    int i = 1;
    for (final condition in command.conditions) {
      final conv = ConditionCommandAdapterMysql.convertToPackage(command: condition).addPrefixToNamed(prefix: 'c$i');
      shieldedFixedValues.addAll(conv.shieldedFixedValues);
      shieldedNamedValues.addAll(conv.shieldedMapedValues);
      textsCommands.add(conv.commandText);
      i += 1;
    }
    buffer.write(TextUtilities.generateCommand(list: textsCommands, character: ' AND \n'));
  }

  static void _convertHavings(QueryCommand command, StringBuffer buffer, List shieldedFixedValues, Map<String, dynamic> shieldedNamedValues) {
    final textsCommands = <String>[];
    int i = 1;
    for (final condition in command.havings) {
      final conv = ConditionCommandAdapterMysql.convertToPackage(command: condition).addPrefixToNamed(prefix: 'c$i');
      shieldedFixedValues.addAll(conv.shieldedFixedValues);
      shieldedNamedValues.addAll(conv.shieldedMapedValues);
      textsCommands.add(conv.commandText);
      i += 1;
    }
    buffer.write(TextUtilities.generateCommand(list: textsCommands, character: ' AND \n'));
  }

  static void _convertOrderBy(QueryCommand command, StringBuffer buffer) {
    for (final item in command.orders) {
      buffer.write('\n ORDER BY ${TextUtilities.generateCommand(list: item.fields.map((x) => '`$x`'))} ${item.isAscendent ? 'ASC' : 'DESC'}');
    }
  }
}
