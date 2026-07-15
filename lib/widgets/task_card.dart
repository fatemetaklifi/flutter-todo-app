import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/theme/app_colors.dart';
import 'package:todo_app/models/task.dart';

// class TaskCard extends StatefulWidget {
//   const TaskCard({super.key, required this.task, required this.isLight});
//
//   final Task task;
//   final bool isLight;
//
//   @override
//   State<TaskCard> createState() => _TaskCardState();
// }

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, required this.isLight});

  final Task task;
  final bool isLight;

  Color get priorityColor {
    switch (task.priority) {
      case TaskPriority.high:
        {
          return isLight ? LightColors.priorityHigh : DarkColors.priorityHigh;
        }
      case TaskPriority.medium:
        {
          return isLight ? LightColors.accent : DarkColors.accent;
        }
      case TaskPriority.low:
        {
          return isLight ? LightColors.secondary : DarkColors.secondary;
        }
      default:
        return Colors.grey.shade400;
    }
  }

  // late DateTime ct = task.createdAt;
  // late final formattedTime =
  //     "${ct.day}/${ct.month}/${ct.year}  ${ct.hour}:${ct.minute}";

  @override
  Widget build(BuildContext context) {
    final background = isLight
        ? (task.status == TaskStatus.completed
              ? LightColors.completeCardBackground
              : LightColors.todoCardBackground)
        : (task.status == TaskStatus.completed
              ? DarkColors.completeCardBackground
              : DarkColors.todoCardBackground);

    final description = task.description?.trim();
    final formattedTime = DateFormat("dd/MM/yyyy HH:mm").format(task.createdAt);

    return Card(
      color: background,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(width: 10),
                if (task.status == TaskStatus.completed) ...[
                  Icon(Icons.check_circle, color: LightColors.checkedTask),
                  SizedBox(width: 3),
                  Text(
                    task.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isLight ? Colors.grey : Colors.grey.shade500,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ] else ...[
                  Icon(Icons.circle_outlined),
                  SizedBox(width: 3),
                  Text(
                    task.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ],
            ),

            if (description?.isNotEmpty ?? false) ...[
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 80),
                child: Text(
                  description!,
                  style: TextStyle(
                    fontSize: 16,
                    color: isLight
                        ? LightColors.descriptionText
                        : DarkColors.descriptionText,
                  ),
                ),
              ),
            ],

            Padding(
              padding: const EdgeInsets.only(left: 40, top: 10),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: priorityColor,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        task.priority.name,
                        style: TextStyle(
                          color: isLight
                              ? LightColors.lightText
                              : DarkColors.darkText,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 10),

                  Container(
                    decoration: BoxDecoration(
                      color: task.status == TaskStatus.completed
                          ? LightColors.checkedTask
                          : LightColors.todoTask,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        task.status.name,
                        style: TextStyle(
                          color: isLight
                              ? LightColors.lightText
                              : DarkColors.darkText,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    formattedTime,
                    style: TextStyle(
                      color: isLight
                          ? DarkColors.darkText.withAlpha(110)
                          : LightColors.lightText.withAlpha(110),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
