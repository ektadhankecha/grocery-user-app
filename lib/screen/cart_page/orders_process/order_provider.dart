import 'package:flutter/material.dart';
import 'package:grocery_app/model/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';

class OrderProvider extends ChangeNotifier {
  List<OrderModel> orderList = [];
  DateTime orderDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  Future<void> addOrder(OrderModel order) async {
    orderList.insert(0, order);
    await saveOrders();
    notifyListeners();
  }

  Future<void> saveOrders() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> orders = orderList
        .map((order) => jsonEncode(order.toJson()))
        .toList();
    await pref.setStringList("OrderList", orders);
  }

  Future<void> loadOrders() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> orders = pref.getStringList('OrderList') ?? [];
    orderList = orders
        .map((order) => OrderModel.fromJson(jsonDecode(order)))
        .toList();
    notifyListeners();
  }

  Future<String> generateOrderNumber() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> oldOrders = pref.getStringList("OrderNumbers") ?? [];
    String orderNumber;
    do {
      orderNumber = (100000 + Random().nextInt(900000)).toString();
    } while (oldOrders.contains(orderNumber));
    oldOrders.add(orderNumber);
    await pref.setStringList("OrderNumbers", oldOrders);
    return orderNumber;
  }
}
