import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Задачи'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/tasks');
            },
          ),
          ListTile(
            leading: Icon(Icons.mood),
            title: Text('Шутка'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/fun');
            },
          ),
        ],
      ),
    );
  }
}
