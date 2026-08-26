import 'package:flutter/material.dart';

class TrackOrderModel {
  final IconData icon;
  final String title;
  final String date;
  final bool isCompleted;

  TrackOrderModel({
    required this.icon,
    required this.title,
    required this.date,
    required this.isCompleted,
  });
}
