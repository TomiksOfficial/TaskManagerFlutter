import 'package:flutter/material.dart';
import '../viewmodels/tasks_viewmodel.dart';

class AddEditTaskScreen extends StatefulWidget {
  final TasksViewModel viewModel;
  final bool isEdit;
  final Map<String, dynamic>? task;
  final int? taskIndex;

  const AddEditTaskScreen({
    super.key,
    required this.viewModel,
    this.isEdit = false,
    this.task,
    this.taskIndex,
  });

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(
      text: widget.isEdit ? (widget.task?['title'] ?? '') : '',
    );
    descController = TextEditingController(
      text: widget.isEdit ? (widget.task?['desc'] ?? '') : '',
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final result = {
        'title': titleController.text,
        'desc': descController.text,
        'done': widget.isEdit ? (widget.task?['done'] ?? false) : false,
        'action': 'save',
        'index': widget.taskIndex,
      };
      Navigator.pop(context, result);
    }
  }

  void _deleteTask() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Удалить задачу?'),
        content: Text('Вы уверены, что хотите удалить эту задачу?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, {
                'action': 'delete',
                'index': widget.taskIndex,
              });
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Удалить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Редактировать задачу' : 'Новая задача'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Название задачи',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введите название задачи';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: descController,
                decoration: InputDecoration(
                  labelText: 'Описание задачи',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введите описание задачи';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _saveTask,
                      icon: Icon(Icons.save),
                      label: Text('Сохранить'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  if (widget.isEdit) SizedBox(width: 8),
                  if (widget.isEdit)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _deleteTask,
                        icon: Icon(Icons.delete),
                        label: Text('Удалить'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
