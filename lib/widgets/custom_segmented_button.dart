import 'package:flutter/material.dart';
import 'package:todo_app/core/theme/app_colors.dart';

class CustomSegmentedButton extends StatefulWidget {
  final List<String> segments;
  final ValueChanged<String> onChanged;
  final String initialValue;
  final bool isLight;

  const CustomSegmentedButton({
    super.key,
    required this.segments,
    required this.onChanged,
    required this.initialValue,
    required this.isLight,
  });

  @override
  State<CustomSegmentedButton> createState() => _CustomSegmentedButtonState();
}

class _CustomSegmentedButtonState extends State<CustomSegmentedButton> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      segments: widget.segments
          .map(
            (e) => ButtonSegment<String>(
              value: e,
              label: Text(e, style: const TextStyle(fontSize: 16)),
              icon: const SizedBox.shrink(),
            ),
          )
          .toList(),
      selected: {selectedValue},
      onSelectionChanged: (newSelection) {
        setState(() => selectedValue = newSelection.first);
        widget.onChanged(selectedValue);
      },
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(
          widget.isLight ? DarkColors.darkText : LightColors.lightText,
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? widget.isLight
                    ? LightColors.primary.withAlpha(150)
                    : DarkColors.primary.withAlpha(150)
              : widget.isLight
              ? LightColors.todoCardBackground
              : DarkColors.todoCardBackground,
        ),
        side: WidgetStateProperty.all(BorderSide(color: LightColors.primary)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      showSelectedIcon: false,
    );
  }
}
