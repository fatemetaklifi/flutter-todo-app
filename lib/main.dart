import 'package:flutter/material.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/repositories/task_repository.dart';
import 'core/theme/app_theme.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/viewModels/home_view_model.dart';

Future<void> main() async {
  final database = DatabaseHelper();
  final repository = TaskRepository(database);
  runApp(MyApp(repository: repository));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.repository});

  final TaskRepository repository;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _changeTheme(ThemeMode newMode) {
    setState(() {
      _themeMode = newMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final vm = HomeViewModel(widget.repository);
        vm.initialize();
        return vm;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _themeMode,
        home: HomePage(
          themeMode: _themeMode,
          onThemeChanged: _changeTheme,
        ),
      ),
    );
  }
}
