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
              if (ModalRoute.of(context)?.settings.name == '/tasks') return;
              
              Navigator.pop(context);
              Navigator.pushNamed(context, '/tasks');
            },
          ),
          ListTile(
            leading: Icon(Icons.mood),
            title: Text('Шутка'),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name == '/fun') return;

              Navigator.pop(context);
              Navigator.pushNamed(context, '/fun');
            },
          ),
        ],
      ),
    );
  }
}
