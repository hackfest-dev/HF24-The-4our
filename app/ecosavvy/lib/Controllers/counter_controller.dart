import 'package:flutter/foundation.dart';

class CounterController extends ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();  // Notify listeners when the value changes
  }
}
