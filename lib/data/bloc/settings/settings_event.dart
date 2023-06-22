part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class ChangeThemeApp extends SettingsEvent {
  final bool isDarkMode;
  ChangeThemeApp({required this.isDarkMode});
}

class GetThemeStatus extends SettingsEvent {}
