import 'package:flutter/material.dart';
import 'package:manager_accounts/presentation/screens/screens.dart';
import 'package:manager_accounts/presentation/widgets/commons/commons.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;
  final List<Widget> _screensList =  [
     const HomeScreen(),
     const UserScreen(),
    const SettingsScreen()
  ];
  
  void onNavigatePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(currentIndex: currentIndex, onNavigatePage: onNavigatePage),
      body: _screensList[currentIndex],
    );
  }
}
