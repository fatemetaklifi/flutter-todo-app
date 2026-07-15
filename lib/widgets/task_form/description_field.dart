import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class DescriptionField extends StatelessWidget {
  const DescriptionField({
    super.key,
    required this.controller,
    required this.isLight,
  });

  final TextEditingController controller;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    final textColor = isLight
        ? LightColors.lightText
        : DarkColors.darkText;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
      child: TextField(
        controller: controller,
        cursorColor: textColor,
        maxLines: 5,
        style: TextStyle(
          color: textColor,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: isLight
              ? Colors.white.withAlpha(20)
              : Colors.black.withAlpha(20),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: textColor,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: textColor,
            ),
          ),
          hint: Text(
            "Task description",
            style: TextStyle(
              fontSize: 17,
              color: textColor.withAlpha(100)
            ),
          ),
        ),
      ),
    );
  }
}
