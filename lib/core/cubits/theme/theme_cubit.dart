import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final Box preferencesBox;

  ThemeCubit({required this.preferencesBox})
    : super(_loadThemeMode(preferencesBox));

  static ThemeMode _loadThemeMode(Box box) {
    final savedTheme = box.get('theme_mode', defaultValue: 'light') as String?;
    if (savedTheme == 'dark') {
      return ThemeMode.dark;
    } else if (savedTheme == 'light') {
      return ThemeMode.light;
    }
    return ThemeMode.light;
  }

  void setLightMode() {
    preferencesBox.put('theme_mode', 'light');
    emit(ThemeMode.light);
  }

  void setDarkMode() {
    preferencesBox.put('theme_mode', 'dark');
    emit(ThemeMode.dark);
  }

  void toggleTheme() {
    if (state == ThemeMode.dark) {
      setLightMode();
      return;
    }
    setDarkMode();
  }
}
