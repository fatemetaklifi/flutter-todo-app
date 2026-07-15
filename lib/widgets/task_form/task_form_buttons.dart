import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class TaskFormButtons extends StatelessWidget {
  const TaskFormButtons({
    super.key,
    required this.isEdit,
    required this.isLight,
    required this.onCancel,
    required this.onSave,
  });

  final bool isEdit;
  final bool isLight;

  final VoidCallback onCancel;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: onCancel,
          child: Text(
            "Cancel",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isLight ? LightColors.accent : DarkColors.accent,
              fontSize: 22,
            ),
          ),
        ),

        const SizedBox(width: 10),

        TextButton(
          onPressed: onSave,
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              isLight ? LightColors.accent : DarkColors.accent,
            ),
          ),
          child: Text(
            isEdit ? "Save" : "Add",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isLight ? LightColors.primary : DarkColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
