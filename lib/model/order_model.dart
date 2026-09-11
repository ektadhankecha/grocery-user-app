import 'package:grocery_app/model/address_model.dart';
import 'package:grocery_app/model/user_model.dart';
import 'order_item_model.dart';

class OrderModel {
  final String? userId;
  final String orderNumber;
  final List<OrderItemModel> items;
  final int totalItems;
  final double totalPrice;
  final String orderDate;
  final String status;
  final String paymentMethod;
  final UserModel user;
  final AddressModel address;

  OrderModel({
    this.userId,
    required this.orderNumber,
    required this.items,
    required this.totalItems,
    required this.totalPrice,
    required this.orderDate,
    required this.status,
    required this.paymentMethod,
    required this.user,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId' : userId ?? user.uid ?? '',
      'orderNumber': orderNumber,
      'items': items.map((item) => item.toJson()).toList(),
      'totalItems': totalItems,
      'totalPrice': totalPrice,
      'orderDate': orderDate,
      'status': status,
      'paymentMethod' : paymentMethod,
      'user' : user.toJson(),
      'address' : address.toJson(),
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      userId: json['userId'] ?? json['uid'] ?? '',
      orderNumber: json['orderNumber'],
      items: (json['items'] as List)
          .map((item) => OrderItemModel.fromJson(item))
          .toList(),
      totalItems: json['totalItems'],
      totalPrice: json['totalPrice'].toDouble(),
      orderDate: json['orderDate'],
      status: json['status'],
      paymentMethod: json['paymentMethod'] ?? "Cash on Delivery",
      user: UserModel.fromJson(json['user'] ?? {}),
      address: AddressModel.fromJson(json['address'] ?? {}),
    );
  }
}

