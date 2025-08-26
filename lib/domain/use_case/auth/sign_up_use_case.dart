import 'package:injectable/injectable.dart';
import '../../repo/auth/auth_repo.dart' show AuthRepository;

@injectable
class SignUpUseCase {
  final AuthRepository _repository;

  SignUpUseCase(this._repository);

  Future<void> call(String email, String password, String name) {
    return _repository.signUpWithEmailAndPassword(email, password, name);
  }
}
