import 'package:injectable/injectable.dart';

import '../../../core/result/result.dart' show Result;

abstract class AuthRepository {
  Future<void> loginWithEmailAndPassword(String email, String password);
  Future<Result<void>> resetPassword(String email);
}
