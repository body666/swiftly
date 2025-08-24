import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/result/result.dart';
import '../../../../domain/use_case/auth/forgot_pass_use_case.dart'
    show ForgotPasswordUseCase;
import 'forgot_pass_state.dart';

@injectable
class ForgotPasswordViewModel extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase _useCase;

  ForgotPasswordViewModel(this._useCase) : super(ForgotPasswordInitial());

  Future<void> resetPassword(String email) async {
    emit(ForgotPasswordLoading()); // Add loading state

    final result = await _useCase.invoke(email);

    if (result is Success) {
      emit(
        ForgotPasswordSuccess(
          'Password reset email sent successfully! Check your inbox.',
        ),
      );
    } else if (result is Fail) {
      emit(ForgotPasswordError(result.exception.toString()));
    }
  }
}
