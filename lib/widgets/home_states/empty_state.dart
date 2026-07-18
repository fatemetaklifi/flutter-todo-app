import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No tasks yet \nTap  +  to create your first task",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22, color: Colors.grey.shade400),
      ),
    );
  }
}
