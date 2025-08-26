import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/use_case/auth/login_use_case.dart';
part 'login_screen_state.dart';

@injectable
class LoginScreenViewModel extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginScreenViewModel(this._loginUseCase) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      await _loginUseCase(email, password);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
