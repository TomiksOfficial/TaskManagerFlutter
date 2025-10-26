import 'package:app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class FunScreen extends StatelessWidget {
  const FunScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quote = 'Стоят в лесу две зубочистки, видят - идёт ёж, одна другой говорит: Не знала, что у нас автобусы ходят';
    return Scaffold(
      appBar: AppBar(title: Text('Шутка')),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: EdgeInsets.all(24),
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  quote,
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Обновить'),
            ),
          ],
        ),
      ),
    );
  }
}
