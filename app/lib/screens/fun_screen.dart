import 'package:app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class FunScreen extends StatefulWidget {
  const FunScreen({super.key});

  @override
  State<FunScreen> createState() => _FunScreenState();
}

class _FunScreenState extends State<FunScreen> {
  final List<String> quotes = [
    'Стоят в лесу две зубочистки, видят - идёт ёж, одна другой говорит: Не знала, что у нас автобусы ходят',
    'Программист — это тот, кто думает, что стакан наполовину полон на 50%',
    'Почему программисты путают Хэллоуин и Рождество? Потому что Oct 31 = Dec 25',
    'Есть 10 типов людей: те, кто понимает двоичную систему, и те, кто не понимает',
    'Компьютер без Windows - как шоколад без фантика',
  ];

  late String currentQuote;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    currentQuote = quotes[0];
  }

  void _updateQuote() {
    setState(() {
      currentQuote = quotes[random.nextInt(quotes.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Шутка')),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              margin: EdgeInsets.all(24),
              elevation: 4,
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  currentQuote,
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _updateQuote,
              icon: Icon(Icons.refresh),
              label: Text('Обновить'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
