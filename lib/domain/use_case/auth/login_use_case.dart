import 'package:injectable/injectable.dart';
import '../../repo/auth/auth_repo.dart' show AuthRepository;

@injectable
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<void> call(String email, String password) {
    return _repository.loginWithEmailAndPassword(email, password);
  }
}
