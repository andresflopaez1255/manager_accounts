import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:manager_accounts/di/register.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';
import 'package:manager_accounts/presentation/screens/dashboard_screen.dart';
import 'package:manager_accounts/presentation/screens/screens.dart';
import 'package:manager_accounts/utils/validations_messages.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  Register().regist();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveFormConfig(
      validationMessages: validationsMessages,
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          
        builder: (context, child) => MaterialApp(
              title: 'Flutter Demo',
              theme: AppTheme.appTheme,
              home: const LoginScreen(),
              initialRoute: '/splash',
              routes: {
                '/splash': (_) => const SplashScreen(),
                '/signIn': (_) => const LoginScreen(),
                '/signUp': (_) => SignUpScreen(),
                '/home': (_) => const DashboardScreen(),
                '/settings': ((context) => const SettingsScreen()),
                '/accountForm': ((context) => const AccountForm())
              },
            ));
  }
}
