import 'package:flutter/material.dart';
import '../widgets/task_list_tile.dart';
import '../widgets/filter_toggle.dart';
import '../widgets/custom_drawer.dart';
import '../screens/add_edit_task_screen.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String filter = 'all';
  List<Map<String, dynamic>> tasks = [
    {'title': 'Учеба', 'desc': 'Подготовить отчёт', 'done': false},
    {'title': 'Магазин', 'desc': 'Купить продукты', 'done': true},
  ];

  List<Map<String, dynamic>> get filteredTasks =>
      filter == 'all' ? tasks : tasks.where((t) => t['done'] == true).toList();

  void _addTask() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditTaskScreen(),
      ),
    );

    if (result != null && result['action'] == 'save') {
      setState(() {
        tasks.add({
          'title': result['title'],
          'desc': result['desc'],
          'done': false,
        });
      });
      _showSnackBar('Задача добавлена');
    }
  }

  void _editTask(int index) async {
    final originalIndex = tasks.indexOf(filteredTasks[index]);
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditTaskScreen(
          isEdit: true,
          task: tasks[originalIndex],
          taskIndex: originalIndex,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        if (result['action'] == 'save') {
          tasks[originalIndex] = {
            'title': result['title'],
            'desc': result['desc'],
            'done': tasks[originalIndex]['done'],
          };
          _showSnackBar('Задача обновлена');
        } else if (result['action'] == 'delete') {
          tasks.removeAt(originalIndex);
          _showSnackBar('Задача удалена');
        }
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Задачи')),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          FilterToggle(
            selected: filter,
            onFilterChanged: (value) {
              setState(() {
                filter = value;
              });
            },
          ),
          Expanded(
            child: filteredTasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.task_alt, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          filter == 'all'
                              ? 'Нет задач'
                              : 'Нет завершённых задач',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];
                      final originalIndex = tasks.indexOf(task);
                      return TaskListTile(
                        title: task['title'] as String,
                        description: task['desc'] as String,
                        completed: task['done'] as bool,
                        onChanged: (val) {
                          setState(() {
                            tasks[originalIndex]['done'] = val ?? false;
                          });
                        },
                        onTap: () => _editTask(index),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Добавить задачу',
        child: Icon(Icons.add),
      ),
    );
  }
}
