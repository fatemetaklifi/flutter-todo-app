import 'package:flutter/material.dart';
import 'package:todo_app/core/theme/app_colors.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/task_form/description_field.dart';
import 'package:todo_app/widgets/task_form/description_toggle.dart';
import 'package:todo_app/widgets/task_form/priority_selector.dart';
import 'package:todo_app/widgets/task_form/task_form_buttons.dart';
import 'package:todo_app/widgets/task_form/task_form_header.dart';
import 'package:todo_app/widgets/task_form/task_title_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key, this.task, required this.isLight});

  final Task? task;
  final bool isLight;

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  late bool showDescription =
      widget.task?.description?.trim().isNotEmpty ?? false;

  late TaskPriority selectedPriority = widget.task != null
      ? widget.task!.priority
      : TaskPriority.none;

  late TextEditingController descriptionController = widget.task != null
      ? TextEditingController(text: widget.task!.description)
      : TextEditingController();
  late TextEditingController titleController = widget.task != null
      ? TextEditingController(text: widget.task!.title)
      : TextEditingController();

  bool isTitleEmpty = false;

  // late final description = descriptionController.text.trim();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void saveTask(){
    if (titleController.text.trim().isNotEmpty) {
      final description = descriptionController.text.trim();
      Navigator.pop(
        context,
        widget.task != null
            ? Task(
          id: widget.task!.id,
          title: titleController.text.trim(),
          priority: selectedPriority,
          description: description.isNotEmpty
              ? description
              : null,
          status: widget.task!.status,
          createdAt: widget.task!.createdAt,
        )
            : Task(
          title: titleController.text.trim(),
          priority: selectedPriority,
          description: description.isNotEmpty
              ? description
              : null,
        ),
      );
    } else {
      setState(() {
        isTitleEmpty = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isLight
        ? LightColors.lightText
        : DarkColors.darkText;

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          30,
          40,
          30,
          MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaskFormHeader(isEdit: widget.task != null, textColor: textColor),

              TaskTitleField(
                controller: titleController,
                isEmpty: isTitleEmpty,
                isLight: widget.isLight,
              ),

              const SizedBox(height: 10),

              Center(
                child: PrioritySelector(
                  selectedPriority: selectedPriority,
                  onChanged: (priority) {
                    setState(() {
                      selectedPriority = priority;
                    });
                  },
                  isLight: widget.isLight,
                ),
              ),

              DescriptionToggle(
                showDescription: showDescription,
                isLight: widget.isLight,
                onToggle: () {
                  setState(() {
                    showDescription = !showDescription;
                  });
                },
              ),

              if (showDescription)
                DescriptionField(
                  controller: descriptionController,
                  isLight: widget.isLight,
                ),

              const SizedBox(height: 10),

              TaskFormButtons(
                isEdit: widget.task != null,
                isLight: widget.isLight,
                onCancel: () {
                  Navigator.pop(context);
                },
                onSave: saveTask
              ),
            ],
          ),
        ),
      ),
    );
  }
}
