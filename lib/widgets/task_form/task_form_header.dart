import 'package:flutter/material.dart';

class TaskFormHeader extends StatelessWidget {
  const TaskFormHeader({
    super.key,
    required this.isEdit,
    required this.textColor,
  });

  final bool isEdit;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 0, 15),
      child: Text(
        isEdit ? "Edit Task" : "Add Task",
        style: TextStyle(
          letterSpacing: 1,
          fontSize: 30,
          fontWeight: FontWeight.w900,
          color: textColor,
        ),
      ),
    );
  }
}
