import 'dart:async';

import 'package:flutter/material.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 10),
        () =>Navigator.pushReplacementNamed(context, '/home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors['primary'],
      body: Center(
        child: Image.asset('assets/images/splash_icon.gif'),
      ),
    );
  }
}
