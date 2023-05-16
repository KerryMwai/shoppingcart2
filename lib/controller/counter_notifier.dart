import 'package:flutter/material.dart';

class CounterNotifier with ChangeNotifier {
  int _counter = 0;
  int get countervalue => _counter;

  incrementCounter() {
    _counter++;
    notifyListeners();
  }

  decrementCounter() {
    _counter--;
    notifyListeners();
  }
}
