import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository {
  static const _themeKey = 'themeMode';

  Future<ThemeMode> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString(_themeKey);
    return theme == 'dark' ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> saveTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _themeKey,
      themeMode == ThemeMode.dark ? 'dark' : 'light',
    );
  }
}
