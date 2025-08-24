import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/auth/forgot_pass/view/forgot_pass_screen.dart'
    show ForgotPasswordScreenView, ForgotPasswordScreen;
import '../../presentation/auth/forgot_pass/view_model/forgot_pass_view_model.dart'
    show ForgotPasswordViewModel;
import '../../presentation/auth/login/view/login_screen_view.dart';
import '../../presentation/auth/login/view_model/login_screen_view_model.dart'
    show LoginScreenViewModel;
import '../di/di.dart' as di;
import 'page_route_name.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteName.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) {
              try {
                return di.getIt<LoginScreenViewModel>();
              } catch (e) {
                print('Error creating LoginCubit: $e');
                rethrow;
              }
            },
            child: const LoginScreen(),
          ),
        );

      case PageRouteName.forgotPassword:
        return _handleMaterialPageRoute(
          widget: BlocProvider(
            create: (context) => di.getIt<ForgotPasswordViewModel>(),
            child: const ForgotPasswordScreen(),
          ),
        );
      default:
        return _handleMaterialPageRoute(widget: const Scaffold());
    }
  }

  static MaterialPageRoute<dynamic> _handleMaterialPageRoute({
    required Widget widget,
  }) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}
