import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/use_case/auth/sign_up_use_case.dart';
part 'signup_screen_state.dart';

@injectable
class SignUpScreenViewModel extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpScreenViewModel(this._signUpUseCase) : super(SignUpInitial());

  Future<void> signUp(String email, String password, String name) async {
    emit(SignUpLoading());
    try {
      await _signUpUseCase(email, password, name);
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }
}
