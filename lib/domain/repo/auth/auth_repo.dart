abstract class AuthRepository {
  Future<void> loginWithEmailAndPassword(String email, String password);
  Future<void> signUpWithEmailAndPassword(
      String email, String password, String name);
}