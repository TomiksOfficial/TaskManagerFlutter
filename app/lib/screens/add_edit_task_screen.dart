import 'package:flutter/material.dart';

class AddEditTaskScreen extends StatelessWidget {
  final bool isEdit;

  const AddEditTaskScreen({super.key, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Редактировать задачу' : 'Новая задача')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Название задачи'),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: descController,
              decoration: InputDecoration(labelText: 'Описание задачи'),
              maxLines: 3,
            ),
            SizedBox(height: 32),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Сохранить'),
                ),
                if (isEdit)
                  SizedBox(width: 8),
                if (isEdit)
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text('Удалить'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
