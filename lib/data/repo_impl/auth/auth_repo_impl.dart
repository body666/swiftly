import 'package:injectable/injectable.dart';

import '../../../domain/repo/auth/auth_repo.dart' show AuthRepository;
import '../../data_source/auth/auth_remote_data_source.dart'
    show AuthRemoteDataSource;

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<void> loginWithEmailAndPassword(String email, String password) {
    return _dataSource.loginWithEmailAndPassword(email, password);
  }
}
