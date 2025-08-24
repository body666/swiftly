import '../../../core/result/result.dart' show Result;

abstract class AuthRemoteDataSource {
  Future<void> loginWithEmailAndPassword(String email, String password);
  Future<Result<void>> resetPassword(String email);
}
