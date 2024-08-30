import 'package:maxi_library/maxi_library.dart';

import 'reflector_test.dart' as reflectable;
import 'reflector_test.reflectable.dart' as generated;

class MaxiLibraryDbMysqlTestReflector extends ReflectorInstance {
  const MaxiLibraryDbMysqlTestReflector({
    super.initializeReflectableFunction = generated.initializeReflectable,
    super.instanceClass = reflectable.reflector,
  });
}
