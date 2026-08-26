import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  String name = '';
  String email = '';
  String contact = '';

  void setUserData({
    required String name,
    required String email,
    required String contact,
  }) {
    this.name = name;
    this.email = email;
    this.contact = contact;
    notifyListeners();
  }
}
