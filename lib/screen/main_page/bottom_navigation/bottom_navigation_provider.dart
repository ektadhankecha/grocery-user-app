import 'package:flutter/material.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int selectedIndex = 0;
  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void resetIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
