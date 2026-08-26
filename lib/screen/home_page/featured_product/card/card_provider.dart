import 'package:flutter/cupertino.dart';
import 'package:grocery_app/model/card_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CardProvider extends ChangeNotifier {
  final List<CardModel> cards = [];

  Future<void> addCard(CardModel card) async {
    cards.add(card);
    await saveCard();
    notifyListeners();
  }

  Future<void> saveCard() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> cardList = cards.map((card) {
      return jsonEncode({
        "name": card.name,
        "cardNumber": card.cardNumber,
        "date": card.date,
        "cvv": card.cvv,
      });
    }).toList();
    await pref.setStringList("CardList", cardList);
  }

  Future<void> loadCard() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> cardList = pref.getStringList("CardList") ?? [];
    cards.clear();
    for (String cardData in cardList) {
      Map<String, dynamic> data = jsonDecode(cardData);
      cards.add(
        CardModel(
          name: data["name"],
          cardNumber: data["cardNumber"],
          date: data["date"],
          cvv: data["cvv"],
        ),
      );
    }
    notifyListeners();
  }
}
