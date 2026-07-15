import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class TaskTitleField extends StatelessWidget {
  const TaskTitleField({
    super.key,
    required this.controller,
    required this.isEmpty,
    required this.isLight,
  });

  final TextEditingController controller;
  final bool isEmpty;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    final textFieldColor =
    isLight
        ? LightColors.lightText
        : DarkColors.textFieldFilled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: textFieldColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: isEmpty
                  ? BorderSide(
                      color: isLight ? Colors.red : Color(0xFFBD130A),
                      width: 1.5,
                    )
                  : BorderSide(
                      color: textFieldColor,
                      width: 2,
                    ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(
                color: textFieldColor,
                width: 2,
              ),
            ),
            hintText: "New Task",
            hintStyle: TextStyle(fontSize: 17, color: Colors.grey),
            suffixIcon: isEmpty
                ? Icon(
                    Icons.error_outline_rounded,
                    color: isLight ? Colors.red : Color(0xFFBD130A),
                    size: 20,
                  )
                : Icon(Icons.edit_note, color: Colors.grey, size: 20),
          ),
        ),

        if (isEmpty) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 6),
            child: Text(
              "Title can not be empty !",
              style: TextStyle(
                color: isLight ? Colors.red : Color(0xFFB81008),
                fontSize: 15,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
