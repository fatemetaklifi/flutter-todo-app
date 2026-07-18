import 'package:flutter/material.dart';
import 'package:todo_app/database/database_helper.dart';
import 'package:todo_app/repositories/task_repository.dart';
import 'package:todo_app/repositories/theme_repository.dart';
import 'package:todo_app/viewModels/theme_view_model.dart';
import 'core/theme/app_theme.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/viewModels/home_view_model.dart';

Future<void> main() async {
  final database = DatabaseHelper();
  final taskRepository = TaskRepository(database);
  final themeRepository = ThemeRepository();
  runApp(
    MyApp(taskRepository: taskRepository, themeRepository: themeRepository),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.taskRepository,
    required this.themeRepository,
  });

  final TaskRepository taskRepository;
  final ThemeRepository themeRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final vm = HomeViewModel(taskRepository);
            vm.initialize();
            return vm;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            final vm = ThemeViewModel(themeRepository);
            vm.initialize();
            return vm;
          },
        ),
      ],
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeVM = context.watch<ThemeViewModel>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeVM.theme,
      home: HomePage(),
    );
  }
}
