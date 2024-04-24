import 'package:manager_accounts/presentation/screens/dashboard_screen.dart';

import 'package:manager_accounts/presentation/screens/screens.dart';

var routes = {
  '/splash': (_) => const SplashScreen(),
  '/signIn': (_) => const LoginScreen(),
  '/signUp': (_) => SignUpScreen(),
  '/home': (_) => const DashboardScreen(),
  '/settings': ((context) => const SettingsScreen()),
  '/accountForm': ((context) => const AccountForm()),
  '/userForm': ((context) => const UserForm())
};
