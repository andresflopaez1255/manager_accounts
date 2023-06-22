part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SetStateStyleMode extends SettingsState {
  final bool isDarkMode;
  final ThemeData? theme;

  SetStateStyleMode({
    required this.isDarkMode,
    this.theme,
  });
}
