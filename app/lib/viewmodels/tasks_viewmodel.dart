import 'package:flutter/foundation.dart';
import '../models/task.dart';
import '../database/database_helper.dart';

class TasksViewModel extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Task> _tasks = [];
  String _filter = 'all';
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  String get filter => _filter;
  bool get isLoading => _isLoading;

  List<Task> get filteredTasks {
    if (_filter == 'all') {
      return _tasks;
    } else {
      return _tasks.where((task) => task.done == true).toList();
    }
  }

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      _tasks = await _dbHelper.getAllTasks();
    } catch (e) {
      debugPrint('Error loading tasks: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setFilter(String newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  Future<void> addTask(String title, String description) async {
    try {
      final task = Task(
        title: title,
        description: description,
        done: false,
      );
      
      final id = await _dbHelper.insertTask(task);
      task.id = id;
      _tasks.add(task);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding task: $e');
    }
  }

  Future<void> updateTask(int index, String title, String description) async {
    if (index >= 0 && index < _tasks.length) {
      try {
        final oldTask = _tasks[index];
        final updatedTask = Task(
          id: oldTask.id,
          title: title,
          description: description,
          done: oldTask.done,
        );
        
        await _dbHelper.updateTask(updatedTask);
        _tasks[index] = updatedTask;
        notifyListeners();
      } catch (e) {
        debugPrint('Error updating task: $e');
      }
    }
  }

  Future<void> deleteTask(int index) async {
    if (index >= 0 && index < _tasks.length) {
      try {
        final task = _tasks[index];
        if (task.id != null) {
          await _dbHelper.deleteTask(task.id!);
        }
        _tasks.removeAt(index);
        notifyListeners();
      } catch (e) {
        debugPrint('Error deleting task: $e');
      }
    }
  }

  Future<void> toggleTaskDone(int index) async {
    if (index >= 0 && index < _tasks.length) {
      try {
        _tasks[index].done = !_tasks[index].done;
        await _dbHelper.updateTask(_tasks[index]);
        notifyListeners();
      } catch (e) {
        debugPrint('Error toggling task: $e');
      }
    }
  }

  int getOriginalIndex(Task task) {
    return _tasks.indexOf(task);
  }

  Future<void> clearAllTasks() async {
    try {
      await _dbHelper.deleteAllTasks();
      _tasks.clear();
      notifyListeners();
    } catch (e) {
      debugPrint('Error clearing tasks: $e');
    }
  }
}
