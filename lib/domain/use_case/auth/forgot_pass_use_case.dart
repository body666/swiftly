import 'package:injectable/injectable.dart';
import '../../../core/result/result.dart' show Result, Fail, Success;
import '../../repo/auth/auth_repo.dart' show AuthRepository;

@injectable
class ForgotPasswordUseCase {
  final AuthRepository _repository;
  ForgotPasswordUseCase(this._repository);
  Future<Result<void>> invoke(String email) async {
    try {
      final result = await _repository.resetPassword(email);
      return result;
    } catch (e) {
      return Fail(exception: Exception(e.toString()));
    }
  }
}
