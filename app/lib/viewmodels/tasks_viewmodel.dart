import 'package:flutter/foundation.dart';
import '../models/task.dart';

class TasksViewModel extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(title: 'Учеба', description: 'Подготовить отчёт', done: false),
    Task(title: 'Магазин', description: 'Купить продукты', done: true),
  ];

  String _filter = 'all';

  List<Task> get tasks => _tasks;
  String get filter => _filter;

  List<Task> get filteredTasks {
    if (_filter == 'all') {
      return _tasks;
    } else {
      return _tasks.where((task) => task.done == true).toList();
    }
  }

  void setFilter(String newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  void addTask(String title, String description) {
    _tasks.add(Task(
      title: title,
      description: description,
      done: false,
    ));
    notifyListeners();
  }

  void updateTask(int index, String title, String description) {
    if (index >= 0 && index < _tasks.length) {
      final oldTask = _tasks[index];
      _tasks[index] = Task(
        title: title,
        description: description,
        done: oldTask.done,
      );
      notifyListeners();
    }
  }

  void deleteTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks.removeAt(index);
      notifyListeners();
    }
  }

  void toggleTaskDone(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index].done = !_tasks[index].done;
      notifyListeners();
    }
  }

  int getOriginalIndex(Task task) {
    return _tasks.indexOf(task);
  }
}
