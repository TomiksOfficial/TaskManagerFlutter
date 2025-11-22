import 'package:flutter/foundation.dart';
import 'dart:math';

class FunViewModel extends ChangeNotifier {
  final List<String> _quotes = [
    'Стоят в лесу две зубочистки, видят - идёт ёж, одна другой говорит: Не знала, что у нас автобусы ходят',
    'Программист — это тот, кто думает, что стакан наполовину полон на 50%',
    'Почему программисты путают Хэллоуин и Рождество? Потому что Oct 31 = Dec 25',
    'Есть 10 типов людей: те, кто понимает двоичную систему, и те, кто не понимает',
    'Компьютер без Windows - как шоколад без фантика',
  ];

  final Random _random = Random();
  late String _currentQuote;

  FunViewModel() {
    _currentQuote = _quotes[0];
  }

  String get currentQuote => _currentQuote;

  void updateQuote() {
    _currentQuote = _quotes[_random.nextInt(_quotes.length)];
    notifyListeners();
  }
}
