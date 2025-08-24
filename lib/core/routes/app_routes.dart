import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/auth/login/view/login_screen_view.dart';
import '../../presentation/auth/login/view/signup_screen_view.dart';
import '../../presentation/auth/login/view_model/login_screen_view_model.dart'
    show LoginScreenViewModel;
import '../../presentation/auth/login/view_model/signup_screen_view_model.dart';
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
      case PageRouteName.signUp:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) {
              try {
                return di.getIt<SignUpScreenViewModel>();
              } catch (e) {
                print('Error creating SignUpScreenViewModel: $e');
                rethrow;
              }
            },
            child: const SignUpScreen(),
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
