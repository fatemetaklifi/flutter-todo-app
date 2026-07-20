import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/theme/app_colors.dart';
import 'package:todo_app/viewModels/theme_view_model.dart';
import 'package:todo_app/widgets/add_task_bottom_sheet.dart';
import 'package:todo_app/widgets/home_header.dart';
import 'package:todo_app/widgets/home_states/empty_state.dart';
import 'package:todo_app/widgets/home_states/error_state.dart';
import 'package:todo_app/widgets/task_list.dart';
import '../viewModels/home_view_model.dart';
import '../widgets/custom_segmented_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeVM = context.read<HomeViewModel>();
    final themeVM = context.watch<ThemeViewModel>();
    final isLight = themeVM.theme == ThemeMode.light;

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
            HomeHeader(isLight: isLight),

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
                width: MediaQuery.of(context).size.width,
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

                        return TaskList(
                          tasks: tasks,
                          isLight: isLight,
                          onDelete: homeVM.removeTask,
                          onChangeStatus: homeVM.changeStatus,
                          onEdit: homeVM.updateTask,
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
