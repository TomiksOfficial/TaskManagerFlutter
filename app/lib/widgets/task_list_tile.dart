import 'package:flutter/material.dart';

class TaskListTile extends StatelessWidget {
  final String title;
  final String description;
  final bool completed;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onTap;

  const TaskListTile({
    super.key,
    required this.title,
    required this.description,
    required this.completed,
    required this.onChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
      trailing: Checkbox(
        value: completed,
        onChanged: onChanged,
      ),
      onTap: onTap,
    );
  }
}
