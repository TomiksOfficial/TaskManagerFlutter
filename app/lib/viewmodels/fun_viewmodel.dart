import 'package:flutter/foundation.dart';
import 'dart:math';
import '../services/joke_service.dart';

class FunViewModel extends ChangeNotifier {
  final List<String> _localQuotes = [
    'Стоят в лесу две зубочистки, видят - идёт ёж, одна другой говорит: Не знала, что у нас автобусы ходят',
    'Программист — это тот, кто думает, что стакан наполовину полон на 50%',
    'Почему программисты путают Хэллоуин и Рождество? Потому что Oct 31 = Dec 25',
    'Есть 10 типов людей: те, кто понимает двоичную систему, и те, кто не понимает',
    'Компьютер без Windows - как шоколад без фантика',
  ];

  final Random _random = Random();
  final JokeService _jokeService = JokeService();
  
  String _currentQuote = '';
  bool _isLoading = false;

  FunViewModel() {
    _currentQuote = _localQuotes[0];
  }

  String get currentQuote => _currentQuote;
  bool get isLoading => _isLoading;

  Future<void> fetchJoke() async {
    _isLoading = true;
    notifyListeners();

    try {
      final joke = await _jokeService.fetchJoke();
      
      if (joke != null) {
        _currentQuote = joke;
      } else {
        _currentQuote = 'Не удалось загрузить шутку';
      }
    } catch (e) {
      _currentQuote = 'Ошибка: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateLocalQuote() {
    _currentQuote = _localQuotes[_random.nextInt(_localQuotes.length)];
    notifyListeners();
  }
}
