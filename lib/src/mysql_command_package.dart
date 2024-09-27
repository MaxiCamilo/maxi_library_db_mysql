import 'package:maxi_library/maxi_library.dart';

class MysqlCommandPackage {
  final String commandText;
  final Map<String, dynamic> shieldedMapedValues;
  final List<dynamic> shieldedFixedValues;
  final int mixPosition;

  const MysqlCommandPackage({
    required this.commandText,
    this.shieldedMapedValues = const {},
    this.shieldedFixedValues = const [],
    this.mixPosition = 1,
  });

  factory MysqlCommandPackage.mergenCommand({
    required MysqlCommandPackage anotherCommand,
    required String commandText,
    required String commandUnion,
    Map<String, dynamic> shieldedMapedValues = const {},
    List shieldedFixedValues = const [],
  }) {
    final newCommand = MysqlCommandPackage(commandText: commandText, shieldedFixedValues: shieldedFixedValues, shieldedMapedValues: shieldedMapedValues);
    return newCommand.mixUp(other: anotherCommand, commandUnion: commandUnion);
  }

  MysqlCommandPackage add({
    String commandUnion = '',
    String commandText = '',
    Map<String, dynamic> shieldedMapedValues = const {},
    List shieldedFixedValues = const [],
  }) {
    return MysqlCommandPackage.mergenCommand(
      anotherCommand: this,
      commandText: commandText,
      commandUnion: commandUnion,
      shieldedFixedValues: shieldedFixedValues,
      shieldedMapedValues: shieldedMapedValues,
    );
  }

  MysqlCommandPackage mixUp({required MysqlCommandPackage other, required String commandUnion}) {
    String newCommandText = other.commandText;
    final newShieldedFixedValues = [...shieldedFixedValues, ...other.shieldedFixedValues];
    final newShieldedMapedValues = Map<String, dynamic>.from(shieldedMapedValues);

    for (final item in other.shieldedMapedValues.entries) {
      final newName = '${item.key}_$mixPosition';
      newCommandText = commandText.replaceAll(':${item.key}', ':$newName');
      newShieldedMapedValues[newName] = item.value;
    }

    return MysqlCommandPackage(
      commandText: '$commandText$commandUnion$newCommandText',
      shieldedFixedValues: newShieldedFixedValues,
      shieldedMapedValues: newShieldedMapedValues,
      mixPosition: mixPosition + 1,
    );
  }

  MysqlCommandPackage addPrefixToNamed({required String prefix, int? mixPosition}) {
    final newMap = <String, dynamic>{};
    String newCommandText = commandText;
    for (final item in shieldedMapedValues.entries) {
      final newName = '${prefix}_${item.key}';
      newCommandText = commandText.replaceAll(':${item.key}', ':$newName');
      newMap[newName] = item.value;
    }

    return MysqlCommandPackage(
      commandText: newCommandText,
      shieldedFixedValues: shieldedFixedValues,
      shieldedMapedValues: newMap,
      mixPosition: mixPosition ?? this.mixPosition,
    );
  }

  (String, Map<String, dynamic>) buildCommand() {
    final newMap = Map<String, dynamic>.of(shieldedMapedValues);
    String newCommandText = commandText;

    for (int i = 0; i < shieldedFixedValues.length; i++) {
      final value = shieldedFixedValues[i];
      final position = newCommandText.searchTextInCommand(textToFind: '?', avoidQuotes: true);
      if (position == -1) {
        throw NegativeResult(
          identifier: NegativeResultCodes.implementationFailure,
          message: tr('It is not possible to build the command, position %1 of a fixed value is missing', [i + 1]),
        );
      }

      final newName = 'fix_$i';
      newCommandText = newCommandText.replaceTextFromPosition(start: position, newText: ':$newName', skipLength: 1);
      newMap[newName] = value;
    }
    return (newCommandText, newMap);
  }
}
