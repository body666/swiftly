import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/di.dart' as di;
import 'firebase_options.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/page_route_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.configureDependencies();

  try {
    // Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize dependency injection
    di.configureDependencies();

    runApp(const MyApp());
  } catch (e) {
    print('Initialization error: $e');
    // Still run the app even if there's an initialization error
    runApp(const MyApp());
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
        );
      },
    );
  }
}