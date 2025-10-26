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
            child: ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                final task = filteredTasks[index];
                return TaskListTile(
                  title: task['title'] as String,
                  description: task['desc'] as String,
                  completed: task['done'] as bool,
                  onChanged: (val) {
                    setState(() {
                      task['done'] = val ?? false;
                    });
                  },
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEditTaskScreen(isEdit: true),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditTaskScreen(),
            ),
          );
        },
        tooltip: 'Добавить задачу',
        child: Icon(Icons.add),
      ),
    );
  }
}
