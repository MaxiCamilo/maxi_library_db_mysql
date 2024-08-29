import 'package:maxi_library/maxi_library.dart';

export 'package:maxi_library_db_mysql/maxi_library_db_mysql.dart';

class ReflectByMaxiLibraryDbMysqlImplementation extends Reflectable {
  const ReflectByMaxiLibraryDbMysqlImplementation()
      : super(
          invokingCapability,
          declarationsCapability,
          typeCapability,
          typingCapability,
          typeRelationsCapability,
          subtypeQuantifyCapability,
          reflectedTypeCapability,
        );
}

const reflectByMaxiLibraryDbMysql = ReflectByMaxiLibraryDbMysqlImplementation();
void main(List<String> args) {}
