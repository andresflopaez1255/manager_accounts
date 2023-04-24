import 'package:flutter/material.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';

class BottomNav extends StatelessWidget {
  final  Function(int index) onNavigatePage;
  final int currentIndex;
  const BottomNav({
    Key? key,
    required, required this.onNavigatePage, required  this.currentIndex 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      unselectedItemColor: const Color(0xFF1C495E),
      selectedItemColor: AppTheme.colors['primary'],
      onTap: onNavigatePage,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.manage_accounts),
          label: 'Cuentas',
        ),

          BottomNavigationBarItem(
          label: 'Usuarios',
          
          icon: Icon(Icons.people),
        ),

         BottomNavigationBarItem(
          label: 'Ajustes',
          
          icon: Icon(Icons.settings),
        ),
    ]);
  }
}