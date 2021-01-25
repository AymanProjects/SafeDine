import 'package:flutter/foundation.dart';

class ScreenIndex with ChangeNotifier {
  int index = 1;

  setScreenIndex(int index) {
    this.index = index;
    notifyListeners();
  }
}