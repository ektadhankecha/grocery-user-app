import 'order_item_model.dart';
class OrderModel {
  final String orderNumber;
  final List<OrderItemModel> items;
  final int totalItems;
  final double totalPrice;
  final DateTime orderDate;
  final String status;

  OrderModel({
    required this.orderNumber,
    required this.items,
    required this.totalItems,
    required this.totalPrice,
    required this.orderDate,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderNumber': orderNumber,
      'items': items.map((item) => item.toJson()).toList(),
      'totalItems': totalItems,
      'totalPrice': totalPrice,
      'orderDate': orderDate.toIso8601String(),
      'status': status,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderNumber: json['orderNumber'],
      items: (json['items'] as List)
          .map((item) => OrderItemModel.fromJson(item))
          .toList(),
      totalItems: json['totalItems'],
      totalPrice: json['totalPrice'].toDouble(),
      orderDate: DateTime.parse(json['orderDate']),
      status: json['status'],
    );
  }
}

