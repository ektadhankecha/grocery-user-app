import 'package:flutter/material.dart';

class ProductModel {
  final String id;
  final String image;
  final String name;
  final String quantity;
  final double price;
  final Color bgColor;
  bool isFavorite;
 // final String? badge;
////  final double rating;
//  final int reviews;
  final String description;

  ProductModel({
    required this.id,
    required this.image,
    required this.name,
    required this.quantity,
    required this.price,
    required this.bgColor,
    this.isFavorite = false,
   // this.badge,
   // required this.rating,
   // required this.reviews,
    required this.description,
  });
  factory ProductModel.fromMap(Map<String, dynamic> map, String docId) {
    return ProductModel(
      id: docId,
      image: map['image']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      quantity: map['quantity']?.toString() ?? '',
      price: double.tryParse(map['price']?.toString()?? '0') ?? 0.0,
      bgColor: (map["bgColor"] is num) ? Color((map['bgColor'] as num).toInt()) : const Color ( 0xFFF5F5F5),
      //  rating: rating,
      //  reviews: reviews,
      description: map['description']?.toString() ?? '',
    );
  }
}
