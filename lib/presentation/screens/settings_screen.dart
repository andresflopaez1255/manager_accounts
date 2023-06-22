import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_accounts/data/bloc/settings/settings_bloc.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';
import 'package:manager_accounts/utils/shared_preference.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            final bloc = context.read<SettingsBloc>();
            return Column(children: [
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
                        ),
                        const Icon(Icons.arrow_forward_ios_sharp)
                      ]),
                ),
              ),
              Card(
                elevation: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Modo oscuro',
                        ),
                        BlocBuilder<SettingsBloc, SettingsState>(
                          builder: (context, state) {
                            if (state is SetStateStyleMode) {
                              return Switch(
                                  activeColor: AppTheme.colors['primary'],
                                  value: state.isDarkMode,
                                  onChanged: ((value) {
                                    bloc.add(ChangeThemeApp(isDarkMode: value));
                                  }));
                            }

                            return Switch(
                                activeColor: AppTheme.colors['primary'],
                                value: false,
                                onChanged: ((value) {
                                  bloc.add(ChangeThemeApp(isDarkMode: value));
                                }));
                          },
                        )
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
                        ),
                        const Icon(Icons.arrow_forward_ios_sharp)
                      ]),
                ),
              ),
              const Text(
                  'Informacion sobre la app Informacion sobre la appInformacion sobre la appInformacion sobre la appInformacion sobre la appInformacion sobre la appInformacion sobre la appInformacion sobre la appInformacion sobre la app')
            ]);
          },
        ),
      ),
    );
  }
}
