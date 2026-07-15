import 'package:flutter/material.dart';
import 'package:todo_app/core/theme/app_colors.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.onConfirm,
    required this.isLight,
  });

  final VoidCallback onConfirm;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "REMOVE",
        style: TextStyle(
          fontFamily: 'bungee',
          fontSize: 22,
          color: isLight ? LightColors.priorityHigh : DarkColors.priorityHigh,
        ),
      ),
      content: Text(
        "Do you want to remove this task?",
        style: TextStyle(
          fontSize: 20,
          color: isLight ? Colors.grey.shade700 : Colors.grey.shade400,
        ),
      ),
      backgroundColor: isLight ? LightColors.background : DarkColors.background,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "CANCEL",
            style: TextStyle(
              fontFamily: 'bungee',
              fontSize: 12,
              color: isLight ? LightColors.primary : DarkColors.primary,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: Text(
            "REMOVE",
            style: TextStyle(
              fontFamily: 'bungee',
              fontSize: 12,
              color: isLight
                  ? LightColors.priorityHigh
                  : DarkColors.priorityHigh,
            ),
          ),
        ),
      ],
    );
  }
}
