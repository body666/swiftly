import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  try {
    getIt.init();
    getIt.registerLazySingleton(() => FirebaseAuth.instance);
  } catch (e) {
    print('Dependency injection initialization error: $e');
    rethrow;
  }
}
