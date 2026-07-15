import 'package:flutter/material.dart';
import 'package:todo_app/repositories/theme_repository.dart';

class ThemeViewModel extends ChangeNotifier {
  ThemeViewModel(this._repository);

  Future<void> initialize() async {
    await loadTheme();
  }

  ThemeMode _theme = ThemeMode.system;
  final ThemeRepository _repository;

  ThemeMode get theme => _theme;

  Future<void> loadTheme() async {
    _theme = await _repository.loadTheme();
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _theme = _theme == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await _repository.saveTheme(_theme);
    notifyListeners();
  }
}
