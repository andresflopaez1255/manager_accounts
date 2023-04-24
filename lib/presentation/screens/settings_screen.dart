import 'package:flutter/material.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Informacion personal',
                          style: AppTheme.textStyle['bodyText3']
                              ?.copyWith(fontSize: 14),
                        ),
                        const Icon(Icons.arrow_forward_ios_sharp)
                      ]),
                ],
              ),
            ),
          ),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cambio de contrasena',
                      style: AppTheme.textStyle['bodyText3']
                          ?.copyWith(fontSize: 14),
                    ),
                    const Icon(Icons.arrow_forward_ios_sharp)
                  ]),
            ),
          ),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Modo oscuro',
                      style: AppTheme.textStyle['bodyText3']
                          ?.copyWith(fontSize: 14),
                    ),
                    Switch(
                        activeColor: AppTheme.colors['primary'],
                        value: true,
                        onChanged: ((value) {}))
                  ]),
            ),
          ),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sobre la aplicación',
                      style: AppTheme.textStyle['bodyText3']
                          ?.copyWith(fontSize: 14),
                    ),
                    const Icon(Icons.arrow_forward_ios_sharp)
                  ]),
            ),
          ),
          const Text(
              'Informacion sobre la app Informacion sobre la appInformacion sobre la appInformacion sobre la appInformacion sobre la appInformacion sobre la appInformacion sobre la appInformacion sobre la appInformacion sobre la app')
        ]),
      ),
    );
  }
}
