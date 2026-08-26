import 'package:flutter/material.dart';

class ProductModel {
  final int id;
  final String image;
  final String name;
  final String quantity;
  final double price;
  final Color bgColor;
  bool isFavorite;
  final String? badge;
  final double rating;
  final int reviews;
  final String description;

  ProductModel({
    required this.id,
    required this.image,
    required this.name,
    required this.quantity,
    required this.price,
    required this.bgColor,
    this.isFavorite = false,
    this.badge,
    required this.rating,
    required this.reviews,
    required this.description,

});
}
