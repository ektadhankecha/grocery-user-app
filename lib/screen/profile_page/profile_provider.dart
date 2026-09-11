// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ProfileProvider extends ChangeNotifier {
//   File? profileImage;
//   Future<void> pickProfileImage(ImageSource source) async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: source);
//     if (image != null) {
//       profileImage = File(image.path);
//       SharedPreferences pref = await SharedPreferences.getInstance();
//       await pref.setString("imageSave", image.path);
//       notifyListeners();
//     }
//   }
//
//   Future<void> loadProfileImage() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     var savedImage = pref.getString("imageSave");
//     if (savedImage != null) {
//       profileImage = File(savedImage);
//       notifyListeners();
//     }
//   }
// }
