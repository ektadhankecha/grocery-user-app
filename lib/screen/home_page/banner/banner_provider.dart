import 'package:flutter/material.dart';

class BannerProvider extends ChangeNotifier {
  int currentIndex = 0;
  bool isForward = true;

  void nextBanner(int bannerCount) {
    if (isForward) {
      if (currentIndex < bannerCount - 1) {
        currentIndex++;
      } else {
        isForward = false;
        currentIndex--;
      }
    } else {
      if (currentIndex > 0) {
        currentIndex--;
      } else {
        isForward = true;
        currentIndex++;
      }
    }
    notifyListeners();
  }
  void changeBanner(int index){
    currentIndex = index;
    notifyListeners();
  }

}
