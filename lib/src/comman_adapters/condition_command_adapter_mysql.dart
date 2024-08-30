import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_mysql/src/mysql_command_package.dart';

mixin ConditionCommandAdapterMysql {
  static MysqlCommandPackage convertToPackage({required IConditionQuery command}) {
    return switch (command.runtimeType) {
      const (CompareValue) => _convertCompareValue(command as CompareValue),
      const (CompareFields) => _convertField(command as CompareFields),
      const (CompareIncludesValues) => _convertIncludeValues(command as CompareIncludesValues),
      const (CompareMultipleComparisons) => _convertToMultipleComparisons(command as CompareMultipleComparisons),
      const (CompareSimilarText) => _convertSimilarText(command as CompareSimilarText),
      _ => throw NegativeResult(identifier: NegativeResultCodes.implementationFailure, message: tr('Condition type is unkowned')),
    };
  }

  //Ex: name = 'Maxi' (or shieldValue == true: name = ?)
  static MysqlCommandPackage _convertCompareValue(CompareValue command) {
    String generalCommandText = command.selectedTable.isNotEmpty ? '`${command.selectedTable}`.`${command.originField}`' : '`${command.originField}`';

    generalCommandText += ' ${convertConditionCompareToText(command.typeComparation)} ';

    if (command.shieldValue) {
      return MysqlCommandPackage(commandText: '$generalCommandText ?', shieldedFixedValues: [command.value]);
    } else {
      final textualValue = command.value is String ? '\'${command.value}\'' : command.value.toString();
      return MysqlCommandPackage(commandText: '$generalCommandText $textualValue');
    }
  }

  static MysqlCommandPackage _convertField(CompareFields command) {
    String generalCommandText = command.originFieldTable.isNotEmpty ? '`${command.originFieldTable}`.`${command.originField}`' : '`${command.originField}`';
    generalCommandText += ' ${convertConditionCompareToText(command.typeComparation)} ';
    generalCommandText += command.compareFieldTable.isNotEmpty ? '`${command.compareFieldTable}`.`${command.compareField}`' : '`${command.compareField}`';

    return MysqlCommandPackage(commandText: generalCommandText);
  }

  static MysqlCommandPackage _convertIncludeValues(CompareIncludesValues command) {
    final buffer = StringBuffer();

    if (command.selectedTable.isNotEmpty) {
      buffer.write('`${command.selectedTable}`.`${command.fieldName}`');
    } else {
      buffer.write('`${command.fieldName}`');
    }

    if (command.isInclusive) {
      buffer.write(' IN (');
    } else {
      buffer.write(' NOT IN (');
    }

    if (command.shieldValue) {
      buffer.write(TextUtilities.generateCommand(list: List.generate(command.options.length, (_) => '?')));
    } else {
      buffer.write(TextUtilities.generateCommand(list: command.options.map((x) => x is String ? '\'$x\'' : x.toString())));
    }

    buffer.write(')');
    return MysqlCommandPackage(commandText: buffer.toString(), shieldedFixedValues: command.shieldValue ? command.options : const []);
  }

  static MysqlCommandPackage _convertToMultipleComparisons(CompareMultipleComparisons command) {
    final buffer = StringBuffer('(');

    final mapValues = <String, dynamic>{};
    final fixedValues = [];

    int i = 1;

    for (final cond in command.conditions) {
      final gener = convertToPackage(command: cond);

      String commandText = gener.commandText;

      for (final namVal in gener.shieldedMapedValues.entries) {
        final newName = '${namVal.key}_$i';
        commandText = commandText.replaceAll(':${namVal.key}', ':$newName');
        mapValues[newName] = namVal.value;
      }

      fixedValues.addAll(gener.shieldedFixedValues);
      buffer.write(commandText);
      i += 1;

      if (cond != command.conditions.last) {
        buffer.write(command.typeComparation == CompareMultipleComparisonsLogic.and ? ' AND ' : ' OR ');
      }
    }

    buffer.write(')');
    return MysqlCommandPackage(
      commandText: buffer.toString(),
      shieldedFixedValues: fixedValues,
      shieldedMapedValues: mapValues,
    );
  }

  static MysqlCommandPackage _convertSimilarText(CompareSimilarText command) {
    String commandText = command.selectedTable.isNotEmpty ? '`${command.selectedTable}`.`${command.fieldName}` LIKE' : '`${command.fieldName}` LIKE';
    String searchedText = command.similarText.trim();

    if (searchedText.first == '%') {
      searchedText = searchedText.extractFrom(since: 1);
    }

    if (searchedText.last == '%') {
      searchedText = searchedText.extractInverselyFrom(since: searchedText.length - 2);
    }

    if (command.shieldValue) {
      return MysqlCommandPackage(commandText: '$commandText %?', shieldedFixedValues: [searchedText]);
    } else {
      return MysqlCommandPackage(commandText: '$commandText \'$searchedText\'');
    }
  }

  static String convertConditionCompareToText(ConditionCompareType type) {
    return switch (type) {
      ConditionCompareType.equal => '=',
      ConditionCompareType.notEqual => '<>',
      ConditionCompareType.greater => '>',
      ConditionCompareType.less => '<',
      ConditionCompareType.greaterEqual => '>=',
      ConditionCompareType.lessEqual => '<=',
    };
  }
}
