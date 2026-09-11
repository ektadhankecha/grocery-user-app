import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/model/card_model.dart';

class CardProvider extends ChangeNotifier {
  final List<CardModel> cards = [];

  Future<void> addCard(CardModel card) async {
    cards.add(card);
    notifyListeners();
    await saveCard();
  }

  Future<void> saveCard() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      await docRef.update({
        'cards': cards.map((card) => card.toJson()).toList(),
      });
    } catch (e) {
      debugPrint("Error saving card to Firestore: $e");
    }
  }

  Future<void> loadCard() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      cards.clear();
      notifyListeners();
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists && doc.data() != null) {
        final List<dynamic> cardList = doc.data()?['cards'] ?? [];
        cards.clear();
        for (var item in cardList) {
          cards.add(CardModel.fromJson(Map<String, dynamic>.from(item)));
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error loading cards from Firestore: $e");
    }
  }

  void clearCards() {
    cards.clear();
    notifyListeners();
  }
}
