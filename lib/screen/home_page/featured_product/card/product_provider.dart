import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> searchResults = [];
  List<ProductModel> productList = [];
  bool hasSearched = false;
  List<ProductModel> cartItems = [];
  Map<String, int> cartQuantities = {};
  List<String> searchHistory = [];
  List<String> discoverMore = [
    "Fresh Grocery",
    "Bananas",
    "cheetos",
    "vegetables",
    "Fruits",
    "discounted items",
    "Fresh vegetables",
  ];
 // ProductProvider({required this.productList});

  void listenProducts(){
    FirebaseFirestore.instance
        .collection("products")
        .snapshots()
        .listen((snapshot){
          print("Total docs found : ${snapshot.docs.length}");
          for (var doc in snapshot.docs) {
            print("Doc ID: ${doc.id}, Data: ${doc.data()}");
          }
          productList = snapshot.docs
              .map((doc) => ProductModel.fromMap(doc.data(),doc.id)).toList();
          print("Successfully mapped ${productList.length} products to list!");
          notifyListeners();
    },
    onError: (error){
      print("====== FIRESTORE ERROR ======");
          print("Firebase product error : $error");
    }
    );
  }

  Future<void> loadSearchHistory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    searchHistory = pref.getStringList('search_history') ?? [];
    notifyListeners();
  }

  Future<void> saveSearchHistory() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList('search_history', searchHistory);
  }

  void addSearchKeyword(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    searchHistory.removeWhere((item) => item.toLowerCase() == trimmed.toLowerCase());
    searchHistory.insert(0, trimmed);

    if (searchHistory.length > 10) {
      searchHistory.removeLast();
    }
    saveSearchHistory();
    notifyListeners();
  }

  Future<void> clearSearchHistory() async {
    searchHistory.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('search_history');
    notifyListeners();
  }



  void toggleFavorite(ProductModel product) {
    product.isFavorite = !product.isFavorite;
    saveFavorite();
    notifyListeners();
  }

  void saveFavorite() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> favoriteProduct = productList
        .where((product) => product.isFavorite)
        .map((product) => product.id.toString())
        .toList();
    await pref.setStringList("FavList", favoriteProduct);
  }

  void loadFavorite() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> favoriteProduct = pref.getStringList('FavList') ?? [];

    for (var product in productList) {
      product.isFavorite = favoriteProduct.contains(product.id.toString());
    }

    notifyListeners();
  }
  void clearCart() async{
    cartItems.clear();
    cartQuantities.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove("CardData");
    await pref.remove("CartQuantities");
    notifyListeners();
  }

  void searchProducts(String query) {
    hasSearched = true;
    searchResults = productList.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    addSearchKeyword(query);
    notifyListeners();
  }

  void nothingSearch() {
    hasSearched = false;
    searchResults = [];
    notifyListeners();
  }

  void addToCart(ProductModel product, int quantity) {
    if (cartItems.contains(product)) {
      cartItems.remove(product);
    }
    cartItems.insert(0, product);
    cartQuantities[product.id] = (cartQuantities[product.id] ?? 0) + quantity;
    saveCart();
    notifyListeners();
  }


  Future<void> saveCart() async {
    String cardData = jsonEncode(
      cartQuantities.map((key, value) => MapEntry(key.toString(), value)),
    );
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("CardData", cardData);
  }

  Future<void> showData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? cardData = pref.getString("CardData");
    if (cardData != null) {
      Map<String, dynamic> data = jsonDecode(cardData);
      cartQuantities = data.map(
        (key, value) => MapEntry(key, value as int),
      );
      for (var product in productList) {
        if (cartQuantities.containsKey(product.id)) {
          cartItems.add(product);
        }
      }
    }
    notifyListeners();
  }

  int get cartBadgeCount {
    return cartQuantities.values.fold(0, (sum, qty) => sum + qty);
  }

  void increaseQuantity(ProductModel product) {
    cartQuantities[product.id] = (cartQuantities[product.id] ?? 1) + 1;
    cartItems.remove(product);
    cartItems.insert(0, product);
    saveCart();
    notifyListeners();
  }

  void decreaseQuantity(ProductModel product) {
    final currentQty = cartQuantities[product.id] ?? 1;

    if (currentQty > 1) {
      cartQuantities[product.id] = currentQty - 1;
    } else {
      cartItems.remove(product);
      cartQuantities.remove(product.id);
    }
    saveCart();

    notifyListeners();
  }

  void productRemove(ProductModel product) {
    cartItems.remove(product);
    cartQuantities.remove(product.id);
    saveCart();

    notifyListeners();
  }

  double get subTotal {
    double total = 0.0;
    for (var product in cartItems) {
      int qty = cartQuantities[product.id] ?? 1;
      total += product.price * qty;
    }
    return total;
  }

  double get shipping {
    return cartItems.isEmpty ? 0.0 : 1.5;
  }

  double get total {
    return subTotal + shipping;
  }
}
