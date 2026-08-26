import 'package:flutter/cupertino.dart';

class OnboardingProvider extends ChangeNotifier {
  int currentIndex = 0;
  final int totalPage;
  OnboardingProvider({required this.totalPage});
  void changePage(int index) {
    currentIndex = index;
    notifyListeners();
  }

  bool isLastPage(int totalPage) {
    return currentIndex == totalPage - 1;
  }
}
