import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String image;
  final String name;
  final Color bgColor;

  CategoryModel({
    required this.id,
    required this.image,
    required this.name,
    required this.bgColor,
  });
  factory CategoryModel.fromMap(Map<String, dynamic> map, String docId) {
    return CategoryModel(
      id: docId,
      image: map['image'] ?? '',
      name: map["name"] ?? '',
      bgColor: Color(map['bgColor'] ?? ''),
    );
  }

}
