import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/model/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> categoryList = [];

  void listenToCategories() {
    FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .listen((snapshot) {
      categoryList = snapshot.docs
          .map((doc) => CategoryModel.fromMap(doc.data(), doc.id))
          .toList();
      notifyListeners();
    });
  }
}