import 'package:flutter/material.dart';
import 'package:grocery_app/model/address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AddressProvider extends ChangeNotifier {
  final List<AddressModel> addresses = [];
  AddressModel? selectedAddress;

  void selectAddress(AddressModel address){
    selectedAddress = address;
    notifyListeners();
  }

  Future<void> addAddresses(AddressModel address) async {
    addresses.add(address);
    await saveAddress();
    notifyListeners();
  }



  Future<void> saveAddress() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> addressList = addresses.map((address) {
      return jsonEncode({
        "name": address.name,
        "email": address.email,
        "phone": address.phone,
        "address": address.address,
        "zipCode": address.zipCode,
        "city": address.city,
        "country": address.country,
      });
    }).toList();

    await pref.setStringList("AddressList", addressList);
  }

  Future<void> loadAddresses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> addressList = prefs.getStringList("AddressList") ?? [];

    addresses.clear();

    for (String addressData in addressList) {
      Map<String, dynamic> data = jsonDecode(addressData);

      addresses.add(
        AddressModel(
          name: data["name"],
          email: data["email"],
          phone: data["phone"],
          address: data["address"],
          zipCode: data["zipCode"],
          city: data["city"],
          country: data["country"],
        ),
      );
    }
    notifyListeners();
  }
}
