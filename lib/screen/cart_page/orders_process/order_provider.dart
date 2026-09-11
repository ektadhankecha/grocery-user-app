import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/model/order_model.dart';
import 'dart:async';

class OrderProvider extends ChangeNotifier {

  final CollectionReference orderCollection = FirebaseFirestore.instance.collection("Orders");
  List<OrderModel> orderList = [];
  StreamSubscription? _orderSubscription;
  DateTime orderDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  Future<void> addOrder(OrderModel order) async {
    orderList.insert(0, order);
    notifyListeners();

    try{
      final orderData = order.toJson();
      orderData['createdAt'] = FieldValue.serverTimestamp();
      await orderCollection.add(orderData);
    }catch(e){
      debugPrint("Error saving order to Firestore: $e");
    }
  }
  Future<void> loadOrders() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      orderList = [];
      notifyListeners();
      return;
    }
    try {
      final QuerySnapshot snapshot = await orderCollection
          .where('userId', isEqualTo: user.uid)
          .get();
      orderList = snapshot.docs.map((doc) {
        return OrderModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      orderList = orderList.reversed.toList();
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading orders from Firestore: $e");
    }
  }
  // Real-time listener from Firestore
  void listenToOrders() {
    _orderSubscription?.cancel();
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      orderList = [];
      notifyListeners();
      return;
    }

    _orderSubscription = orderCollection
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .listen((snapshot) {
      orderList = snapshot.docs.map((doc) {
        return OrderModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList().reversed.toList();
      notifyListeners();
    }, onError: (error) {
      debugPrint("Order Stream Error: $error");
    });
  }

  void clearOrders() {
    _orderSubscription?.cancel();
    _orderSubscription = null;
    orderList = [];
    notifyListeners();
  }


  Future<String> generateOrderNumber() async {
    final counterRef = FirebaseFirestore.instance.collection('counters').doc('orders');

    return await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(counterRef);

      int nextOrderNumber = 10001; // Starting order number

      if (snapshot.exists && snapshot.data() != null) {
        nextOrderNumber = (snapshot.data()?['lastOrderNumber'] ?? 10000) + 1;
        transaction.update(counterRef, {'lastOrderNumber': nextOrderNumber});
      } else {
        transaction.set(counterRef, {'lastOrderNumber': nextOrderNumber});
      }

      return nextOrderNumber.toString();
    });
  }

}
