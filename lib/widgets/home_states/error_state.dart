import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({super.key, required this.isLight, required this.onRetry});

  final bool isLight;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.warning_rounded, color: Colors.grey.shade400),
              SizedBox(width: 5),
              Text(
                "Something went wrong",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, color: Colors.grey.shade400),
              ),
            ],
          ),
          SizedBox(height: 50),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                isLight
                    ? LightColors.primary.withAlpha(110)
                    : DarkColors.primary.withAlpha(150),
              ),
              foregroundColor: WidgetStatePropertyAll(
                isLight ? DarkColors.darkText : LightColors.lightText,
              ),
            ),
            onPressed: onRetry,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.refresh_rounded),
                SizedBox(width: 10),
                Text("Retry", style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
