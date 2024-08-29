import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_mysql/src/comman_adapters/condition_command_adapter_mysql.dart';
import 'package:maxi_library_db_mysql/src/mysql_command_package.dart';

mixin DeleteCommandAdapterMysql {
  static MysqlCommandPackage convertToPackage({required DeleteCommand command}) {
    final buffer = StringBuffer('DELETE FROM `${command.tableName}`');

    if (command.conditions.isNotEmpty) {
      MysqlCommandPackage package = MysqlCommandPackage(commandText: buffer.toString());

      for (final cond in command.conditions) {
        package = package.mixUp(
          other: ConditionCommandAdapterMysql.convertToPackage(command: cond),
          commandUnion: command.conditions.first == cond ? '\n WHERE ' : '\n AND ',
        );
      }

      package = package.add(commandText: ';');

      return package;
    } else {
      buffer.write(';');
      return MysqlCommandPackage(commandText: buffer.toString());
    }
  }
}
