import 'package:flutter/material.dart';
import 'screens/tasks_screen.dart';
import 'screens/fun_screen.dart';
import 'screens/add_edit_task_screen.dart';

void main() {
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Менеджер задач',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 177, 22, 212)),
        useMaterial3: true,
      ),
      home: TasksScreen(),
      routes: {
        '/tasks': (context) => TasksScreen(),
        '/fun': (context) => FunScreen(),
        '/addTask': (context) => AddEditTaskScreen(),
      },
    );
  }
}
