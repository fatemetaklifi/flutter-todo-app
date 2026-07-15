import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/task.dart';

class PrioritySelector extends StatelessWidget {
  const PrioritySelector({
    super.key,
    required this.selectedPriority,
    required this.onChanged,
    required this.isLight,
  });

  final TaskPriority selectedPriority;
  final ValueChanged<TaskPriority> onChanged;
  final bool isLight;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: [
        ChoiceChip(
          selected: selectedPriority == TaskPriority.high,
          onSelected: (_) {
            onChanged(TaskPriority.high);
          },
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selectedPriority == TaskPriority.high)
                Icon(
                  Icons.star_rate_rounded,
                  color: isLight ? LightColors.lightText : DarkColors.darkText,
                  size: 15,
                ),
              Text("High"),
            ],
          ),
          labelStyle: TextStyle(
            color: isLight ? LightColors.lightText : DarkColors.darkText,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.transparent),
          ),
          color: WidgetStatePropertyAll(isLight ? LightColors.priorityHigh : DarkColors.priorityHigh),
          showCheckmark: false,
        ),
        ChoiceChip(
          selected: selectedPriority == TaskPriority.medium,
          onSelected: (_) {
            onChanged(TaskPriority.medium);
          },
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selectedPriority == TaskPriority.medium)
                Icon(
                  Icons.star_rate_rounded,
                  color: isLight ? LightColors.lightText : DarkColors.darkText,
                  size: 15,
                ),
              Text("Medium"),
            ],
          ),
          labelStyle: TextStyle(
            color: isLight ? LightColors.lightText : DarkColors.darkText,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.transparent),
          ),
          color: WidgetStatePropertyAll(isLight ? LightColors.accent : DarkColors.accent),
          showCheckmark: false,
        ),
        ChoiceChip(
          selected: selectedPriority == TaskPriority.low,
          onSelected: (_) {
            onChanged(TaskPriority.low);
          },
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selectedPriority == TaskPriority.low)
                Icon(
                  Icons.star_rate_rounded,
                  color: isLight ? LightColors.lightText : DarkColors.darkText,
                  size: 15,
                ),
              Text("Low"),
            ],
          ),
          labelStyle: TextStyle(
            color: isLight ? LightColors.lightText : DarkColors.darkText,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.transparent),
          ),
          color: WidgetStatePropertyAll(isLight ? LightColors.secondary : DarkColors.secondary),
          showCheckmark: false,
        ),
        ChoiceChip(
          selected: selectedPriority == TaskPriority.none,
          onSelected: (_) {
            onChanged(TaskPriority.none);
          },
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selectedPriority == TaskPriority.none)
                Icon(
                  Icons.star_rate_rounded,
                  color: isLight ? LightColors.lightText : DarkColors.darkText,
                  size: 15,
                ),
              Text("None"),
            ],
          ),
          labelStyle: TextStyle(
            color: isLight ? LightColors.lightText : DarkColors.darkText,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.transparent),
          ),
          color: WidgetStatePropertyAll(Colors.grey.shade400),
          showCheckmark: false,
        ),
      ],
    );
  }
}
