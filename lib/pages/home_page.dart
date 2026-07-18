import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/theme/app_colors.dart';
import 'package:todo_app/viewModels/theme_view_model.dart';
import 'package:todo_app/widgets/add_task_bottom_sheet.dart';
import 'package:todo_app/widgets/home_state/empty_state.dart';
import 'package:todo_app/widgets/home_state/error_state.dart';
import 'package:todo_app/widgets/task_card.dart';
import 'package:todo_app/widgets/confirm_dialog.dart';
import '../viewModels/home_view_model.dart';
import '../widgets/custom_segmented_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Timer _timeTimer;
  late final Timer _dateTimer;
  String _currentTime = '';
  String _currentDate = '';

  void _updateTime() {
    final now = DateTime.now();
    final formattedTime = DateFormat('Hm').format(now);

    if (mounted) {
      setState(() {
        _currentTime = formattedTime;
      });
    }
  }

  void _updateDate() {
    final now = DateTime.now();
    final formattedDate = DateFormat('yMMMEd').format(now);

    if (mounted) {
      setState(() {
        _currentDate = formattedDate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _updateTime();
    _updateDate();
    _timeTimer = Timer.periodic(const Duration(seconds: 60), (timer) {
      _updateTime();
    });
    _dateTimer = Timer.periodic(const Duration(days: 1), (timer) {
      _updateDate();
    });
  }

  @override
  void dispose() {
    _timeTimer.cancel();
    _dateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeVM = context.read<HomeViewModel>();
    final themeVM = context.watch<ThemeViewModel>();
    final isLight = themeVM.theme == ThemeMode.light;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TO DO App",
          style: TextStyle(fontFamily: 'bungee', fontSize: 26),
        ),
        leading: Padding(
          padding: EdgeInsets.all(12),
          child: Icon(Icons.menu_rounded),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(12, 7, 12, 12),
            child: IconButton(
              onPressed: () {
                themeVM.toggleTheme();
              },
              icon: isLight
                  ? Icon(Icons.dark_mode_outlined, color: DarkColors.secondary)
                  : Icon(Icons.light_mode, color: LightColors.accent),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height * (0.20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentTime.isEmpty ? "--:--" : _currentTime,
                      style: TextStyle(
                        fontFamily: 'bungee',
                        fontSize: 75,
                        fontWeight: FontWeight.bold,
                        color: isLight
                            ? LightColors.primary
                            : DarkColors.primary,
                      ),
                    ),
                    Text(
                      _currentDate,
                      style: TextStyle(
                        fontFamily: 'bungee',
                        fontSize: 13,
                        color: isLight
                            ? Colors.grey.shade600
                            : Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CustomSegmentedButton(
                segments: ['All', 'Todo', 'Completed'],
                onChanged: (value) {
                  homeVM.changeFilter(switch (value) {
                    'All' => StatusFilter.all,
                    'Todo' => StatusFilter.todo,
                    'Completed' => StatusFilter.completed,
                    _ => StatusFilter.all,
                  });
                },
                initialValue: 'All',
                isLight: isLight,
              ),
            ),

            Expanded(
              child: SizedBox(
                width: size.width,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Consumer<HomeViewModel>(
                      builder: (context, vm, child) {
                        final tasks = vm.filteredTasks;

                        if (vm.state == HomeState.loading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: isLight
                                  ? LightColors.secondary
                                  : DarkColors.accent,
                            ),
                          );
                        }

                        if (vm.state == HomeState.error) {
                          return ErrorState(
                            isLight: isLight,
                            onRetry: vm.loadTasks,
                          );
                        }

                        if (tasks.isEmpty) {
                          return EmptyState();
                        }

                        return ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final task = tasks[index];
                            return Dismissible(
                              key: Key(task.id.toString()),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction) async {
                                return await showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ConfirmDialog(
                                      isLight: isLight,
                                      onConfirm: () async {
                                        await homeVM.removeTask(task.id);
                                      },
                                    );
                                  },
                                );
                              },
                              background: Container(
                                color: isLight
                                    ? LightColors.priorityHigh
                                    : DarkColors.priorityHigh,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 3),
                                child: InkWell(
                                  onTap: () async {
                                    await homeVM.changeStatus(task);
                                  },
                                  onLongPress: () async {
                                    final result = await showModalBottomSheet(
                                      barrierColor: Colors.black.withAlpha(180),
                                      isScrollControlled: true,
                                      context: context,
                                      backgroundColor: isLight
                                          ? LightColors.primary
                                          : DarkColors.primary,
                                      builder: (context) {
                                        return AddTaskBottomSheet(
                                          task: task,
                                          isLight: isLight,
                                        );
                                      },
                                    );
                                    if (result != null) {
                                      await homeVM.updateTask(result);
                                    }
                                  },
                                  child: TaskCard(task: task, isLight: isLight),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 40, right: 30),
                      child: FloatingActionButton(
                        onPressed: () async {
                          final result = await showModalBottomSheet(
                            barrierColor: Colors.black.withAlpha(180),
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: isLight
                                ? LightColors.primary
                                : DarkColors.primary,
                            builder: (context) {
                              return AddTaskBottomSheet(isLight: isLight);
                            },
                          );
                          if (result != null) {
                            await homeVM.addTask(result);
                          }
                        },
                        backgroundColor: isLight
                            ? LightColors.accent
                            : DarkColors.accent,
                        child: Icon(
                          Icons.add,
                          color: isLight
                              ? LightColors.primary
                              : DarkColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
