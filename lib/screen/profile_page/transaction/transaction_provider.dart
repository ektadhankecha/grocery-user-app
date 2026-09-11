 import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:grocery_app/model/transactions_model.dart';

class TransactionProvider extends ChangeNotifier {
  List<TransactionsModel> transactionList = [];
  DateTime transactionDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
  );
  Future<void> addTransaction(TransactionsModel transaction) async {
    transactionList.insert(0, transaction);
    notifyListeners();
    await saveTransactions();

  }

  Future<void> saveTransactions() async {
    final user = FirebaseAuth.instance.currentUser;
    if(user == null) return;

    try{
      final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      await docRef.update({
        'transaction' : transactionList.map((transactionList) => transactionList.toJson()).toList(),

      });
    }catch(e){
      debugPrint("Error saving transaction on FireStore: $e");
    }
  }

  Future<void> loadTransactions() async {
    final user = FirebaseAuth.instance.currentUser;
    if(user == null){
      transactionList.clear();
      notifyListeners();
      return;
    }
    try{
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if(doc.exists && doc.data() != null){
        final List<dynamic> transaction = doc.data()?['transaction'] ?? [];
        transactionList.clear();
        for(var item in transaction){
          transactionList.add(TransactionsModel.fromJson(Map<String, dynamic>.from(item)));
        }
        notifyListeners();
      }
    }catch(e){
      debugPrint("Error loading transaction from firebase: $e");
    }
  }

  void clearTransactions(){
    transactionList.clear();
    notifyListeners();
  }
}
