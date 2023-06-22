import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_accounts/utils/config/AppTheme.dart';
import 'package:manager_accounts/utils/shared_preference.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<ChangeThemeApp>(_changeThemeApp);
    on<GetThemeStatus>(_getThemeStatus);
  }

  FutureOr<void> _changeThemeApp(
      ChangeThemeApp event, Emitter<SettingsState> emit) async {
    await SharedPref().save("themeMode", event.isDarkMode);
    _validateStateTheme(event.isDarkMode, emit);
  }

  Future<void> _getThemeStatus(
      GetThemeStatus event, Emitter<SettingsState> emit) async {
    final stateTheme = await SharedPref().read("themeMode");
    _validateStateTheme(stateTheme, emit);
  }

  void _validateStateTheme(bool state, Emitter<SettingsState> emit) {
    final theme = state ? AppTheme.appThemeDark : AppTheme.appTheme;
    emit(SetStateStyleMode(isDarkMode: state, theme: theme));
  }
}
