import 'package:injectable/injectable.dart';

@injectable
abstract class AuthRepository {
  Future<void> loginWithEmailAndPassword(String email, String password);
}
