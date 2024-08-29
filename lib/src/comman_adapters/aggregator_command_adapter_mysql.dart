import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_mysql/src/mysql_command_package.dart';

mixin AggregatorCommandAdapterMysql {
  static MysqlCommandPackage convertToPackage({required AggregatorCommand command}) {
    final buffer = StringBuffer('INSERT INTO `${command.tableName}` (');
    buffer.write(TextUtilities.generateCommand(list: command.dataField.keys, function: (p0) => '`$p0`'));
    buffer.write(') VALUES (');
    buffer.write(TextUtilities.generateCommand(list: command.dataField.keys, function: (p0) => ':$p0'));
    buffer.write(');');

    return MysqlCommandPackage(commandText: buffer.toString(), shieldedMapedValues: command.dataField);
  }
}
