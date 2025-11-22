import 'package:flutter/material.dart';
import '../viewmodels/tasks_viewmodel.dart';
import '../widgets/task_list_tile.dart';
import '../widgets/filter_toggle.dart';
import '../widgets/custom_drawer.dart';
import '../screens/add_edit_task_screen.dart';

// class TasksScreen extends StatefulWidget {
//   const TasksScreen({super.key});

//   @override
//   State<TasksScreen> createState() => _TasksScreenState();
// }

class TasksScreen extends StatelessWidget {
  final TasksViewModel _viewModel = TasksViewModel();
  final BuildContext context;

  TasksScreen({super.key, required this.context});

  void _addTask() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditTaskScreen(viewModel: _viewModel),
      ),
    );
    if (result != null && result['action'] == 'save') {
      _viewModel.addTask(result['title'], result['desc']);
      _showSnackBar('Задача добавлена');
    }
  }

  void _editTask(int index) async {
    final filteredTasks = _viewModel.filteredTasks;
    final task = filteredTasks[index];
    final originalIndex = _viewModel.getOriginalIndex(task);

    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditTaskScreen(
          viewModel: _viewModel,
          isEdit: true,
          task: task.toMap(),
          taskIndex: originalIndex,
        ),
      ),
    );

    if (result != null) {
      if (result['action'] == 'save') {
        _viewModel.updateTask(originalIndex, result['title'], result['desc']);
        _showSnackBar('Задача обновлена');
      } else if (result['action'] == 'delete') {
        _viewModel.deleteTask(originalIndex);
        _showSnackBar('Задача удалена');
      }
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
      body: AnimatedBuilder(
        animation: _viewModel,
        builder: (context, _) {
          final filteredTasks = _viewModel.filteredTasks;
          return Column(
            children: [
              FilterToggle(
                selected: _viewModel.filter,
                onFilterChanged: (value) {
                  _viewModel.setFilter(value);
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
                              _viewModel.filter == 'all'
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
                          final originalIndex = _viewModel.getOriginalIndex(task);
                          return TaskListTile(
                            title: task.title,
                            description: task.description,
                            completed: task.done,
                            onChanged: (val) {
                              _viewModel.toggleTaskDone(originalIndex);
                            },
                            onTap: () => _editTask(index),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Добавить задачу!',
        child: Icon(Icons.add),
      ),
    );
  }
}
