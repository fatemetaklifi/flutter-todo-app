import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class DescriptionToggle extends StatelessWidget {
  const DescriptionToggle({
    super.key,
    required this.showDescription,
    required this.isLight,
    required this.onToggle,
  });

  final bool showDescription;
  final bool isLight;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton.icon(
          onPressed: onToggle,
          icon: Icon(
            showDescription
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down,
            size: 17,
          ),
          label: Text(
            showDescription ? "Hide description" : "Show description",
            style: TextStyle(fontSize: 16, letterSpacing: 1),
          ),
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(
              isLight ? LightColors.lightText : DarkColors.darkText,
            ),
          ),
        ),
      ],
    );
  }
}
