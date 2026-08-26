import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:grocery_app/model/transactions_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    await saveTransactions();
    notifyListeners();
  }

  Future<void> saveTransactions() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> transaction = transactionList
        .map((transaction) => jsonEncode(transaction.toJson()))
        .toList();
    await pref.setStringList("TransactionList", transaction);
  }

  Future<void> loadTransactions() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> transactions = pref.getStringList("TransactionList") ?? [];
    transactionList = transactions
        .map(
          (transactions) =>
              TransactionsModel.fromJson(jsonDecode(transactions)),
        )
        .toList();
    notifyListeners();
  }
}
