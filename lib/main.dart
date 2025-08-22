import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiftly/presentation/auth/login/view_model/login_screen_view_model.dart'
    show LoginCubit, LoginScreenViewModel;
import 'core/di/di.dart' as di;

import 'core/routes/app_routes.dart' show AppRoutes;
import 'core/routes/page_route_name.dart';
import 'presentation/auth/login/view/login_screen_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    await di.configureDependencies();
    runApp(const MyApp());
  } catch (e) {
    print('Initialization error: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Swiftly',
          theme: ThemeData(
            primaryColor: const Color(0xFF00BFA6), // Electric Teal
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: const Color(0xFFFF7A5A), // Bright Coral
            ),
            scaffoldBackgroundColor: const Color(0xFFF9F9F9), // Off-White
            textTheme: TextTheme(
              bodyLarge: TextStyle(
                color: const Color(0xFF2F2F2F), // Charcoal Gray
                fontSize: 16.sp,
              ),
            ),
            dividerColor: const Color(0xFFE0E0E0), // Light Gray
          ),
          initialRoute: PageRouteName.login,
          onGenerateRoute: AppRoutes.onGenerateRoute,
          home: BlocProvider(
            create: (_) => di.getIt<LoginScreenViewModel>(),
            child: const LoginScreen(),
          ),
        );
      },
    );
  }
}
