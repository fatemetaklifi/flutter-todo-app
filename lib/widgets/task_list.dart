import 'package:flutter/material.dart';
import 'package:todo_app/widgets/task_card.dart';
import '../core/theme/app_colors.dart';
import '../models/task.dart';
import 'add_task_bottom_sheet.dart';
import 'confirm_dialog.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.tasks,
    required this.isLight,
    required this.onDelete,
    required this.onChangeStatus,
    required this.onEdit,
  });

  final List<Task> tasks;
  final bool isLight;
  final Future<void> Function(String id) onDelete;
  final Future<void> Function(Task task) onChangeStatus;
  final Future<void> Function(Task task) onEdit;

  @override
  Widget build(BuildContext context) {
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
                    await onDelete(task.id);
                  },
                );
              },
            );
          },
          background: Container(
            color: isLight ? LightColors.priorityHigh : DarkColors.priorityHigh,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.delete, color: Colors.white),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: InkWell(
              onTap: () async {
                await onChangeStatus(task);
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
                    return AddTaskBottomSheet(task: task, isLight: isLight);
                  },
                );
                if (result != null) {
                  onEdit(result);
                }
              },
              child: TaskCard(task: task, isLight: isLight),
            ),
          ),
        );
      },
    );
  }
}
