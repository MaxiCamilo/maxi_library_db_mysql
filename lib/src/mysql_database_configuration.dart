import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_mysql/maxi_library_db_mysql.dart';

@reflect
class MysqlDatabaseConfiguration with IDataBaseConfiguration {
  @CheckIp()
  String host = '127.0.0.1';
  @CheckIpPort(acceptZero: false)
  int port = 3306;
  @CheckTextLength(minimum: 1, maximum: 120)
  String user = '';
  @CheckTextLength(minimum: 0, maximum: 256)
  String password = '';
  @CheckTextLength(minimum: 1, maximum: 120)
  String dataBase = '';
  @CheckNumberRange(minimum: 1, maximum: 256)
  int maxActiveConnections = 30;
  bool secureConnection = false;
  @CheckNumberRange(minimum: 1000, maximum: 60000)
  int millisecondsInTimeout = 7500;
  @CheckNumberRange(minimum: 0)
  int openConnectionSeconds = 30;

  @override
  MysqlDatabaseEngine generateEngine({
    List<ISemaphore> synchronizerSemaphores = const [],
    List<ISemaphore> lockersSemaphores = const [],
  }) {
    return MysqlDatabaseEngine(
      configuration: this,
      connectWithDatabaseSelected: true,
      synchronizerSemaphores: synchronizerSemaphores,
      lockersSemaphores: lockersSemaphores,
    );
  }

  MysqlDatabaseEngine generateEngineWithoutAssignedDatabase({
    List<ISemaphore> synchronizerSemaphores = const [],
    List<ISemaphore> lockersSemaphores = const [],
  }) {
    return MysqlDatabaseEngine(
      configuration: this,
      connectWithDatabaseSelected: false,
      synchronizerSemaphores: synchronizerSemaphores,
      lockersSemaphores: lockersSemaphores,
    );
  }
}
