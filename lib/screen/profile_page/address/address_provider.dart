import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/model/address_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressProvider extends ChangeNotifier {
  final List<AddressModel> addresses = [];
  AddressModel? selectedAddress;

  void selectAddress(AddressModel address){
    selectedAddress = address;
    notifyListeners();
  }

  Future<void> addAddresses(AddressModel address) async {
    addresses.add(address);
    if (selectedAddress == null) {
      selectedAddress = address;
    }
    notifyListeners();
    await saveAddress();

  }



  Future<void> saveAddress() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      await docRef.update({
        'addresses': addresses.map((a) => a.toJson()).toList(),
      });
    } catch (e) {
      debugPrint("Error saving address to Firestore: $e");
    }
  }

  Future<void> loadAddresses() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      addresses.clear();
      selectedAddress = null;
      notifyListeners();
      return;
    }
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists && doc.data() != null) {
        final List<dynamic> addressList = doc.data()?['addresses'] ?? [];
        addresses.clear();
        for (var item in addressList) {
          addresses.add(AddressModel.fromJson(Map<String, dynamic>.from(item)));
        }
        if (addresses.isNotEmpty && selectedAddress == null) {
          selectedAddress = addresses.first;
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error loading addresses from Firestore: $e");
    }
  }
  void clearAddresses() {
    addresses.clear();
    selectedAddress = null;
    notifyListeners();
  }
}
