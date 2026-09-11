import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
          loadFavorite();
          _syncCartItems();
          print("Successfully mapped ${productList.length} products to list!");
          notifyListeners();
    },
    onError: (error){
      print("====== FIRESTORE ERROR ======");
          print("Firebase product error : $error");
    }
    );
  }

  void _syncCartItems() {
    cartItems.clear();
    for (var product in productList) {
      if (cartQuantities.containsKey(product.id.toString())) {
        cartItems.add(product);
      }
    }
  }

  Future<void> loadSearchHistory() async {
    final user = FirebaseAuth.instance.currentUser;
    if(user == null ){
      searchHistory.clear();
      notifyListeners();
      return;
    }
    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists && doc.data() != null) {
        final List<dynamic> history = doc.data()?['searchHistory'] ?? [];
        searchHistory = history.map((e) => e.toString()).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error loading search history from Firestore: $e");
    }
  }

  Future<void> saveSearchHistory() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      await docRef.update({
        'searchHistory': searchHistory,
      });
    } catch (e) {
      debugPrint("Error saving search history to Firestore: $e");
    }
  }


  void addSearchKeyword(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;

    searchHistory.removeWhere((item) => item.toLowerCase() == trimmed.toLowerCase());
    searchHistory.insert(0, trimmed);

    if (searchHistory.length > 10) {
      searchHistory.removeLast();
    }
    notifyListeners();
    saveSearchHistory();

  }

  Future<void> clearSearchHistory() async {
    searchHistory.clear();
    notifyListeners();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'searchHistory': [],
        });
      } catch (e) {
        debugPrint("Error clearing search history on Firestore: $e");
      }
    }
  }


  Future<void> toggleFavorite(ProductModel product) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    product.isFavorite = !product.isFavorite;
    notifyListeners();

    try {
      final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      if (product.isFavorite) {
        // Add to array
        await docRef.update({
          'favorites': FieldValue.arrayUnion([product.id.toString()])
        });
      } else {
        // Remove from array
        await docRef.update({
          'favorites': FieldValue.arrayRemove([product.id.toString()])
        });
      }
    } catch (e) {
      debugPrint("Error updating favorite: $e");
    }
  }

  Future<void> loadFavorite() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // If no user is logged in, mark all as false
      for (var product in productList) {
        product.isFavorite = false;
      }
      notifyListeners();
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists && doc.data() != null) {
        final List<dynamic> favList = doc.data()?['favorites'] ?? [];
        for (var product in productList) {
          product.isFavorite = favList.contains(product.id.toString());
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error loading favorites: $e");
    }
  }

  void clearCart() async{
    cartItems.clear();
    cartQuantities.clear();
    notifyListeners();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'cart': {},
        });
      } catch (e) {
        debugPrint("Error clearing cart: $e");
      }
    }
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
      cartItems.insert(0, product);
    }
    final key = product.id.toString();
    cartQuantities[key] = (cartQuantities[key] ?? 0) + quantity;
    saveCart();
    notifyListeners();
  }


  Future<void> saveCart() async {
    final user = FirebaseAuth.instance.currentUser;
    if(user == null) return;
    try{
      final docRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
      await docRef.update({
        'cart' : cartQuantities,
      });
    }catch(e){
      debugPrint("Error saving cart to Firebase: $e");
    }
  }

  Future<void> loadCart() async {
    final user = FirebaseAuth.instance.currentUser;
    if(user == null){
      cartItems.clear();
      cartQuantities.clear();
      notifyListeners();
      return;
    }

    try{
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if(doc.exists && doc.data() != null){
        final Map<String, dynamic> rawCart = doc.data()? ['cart'] ?? {};
        cartQuantities = rawCart.map(
              (key, value) => MapEntry(key, (value as num).toInt()),
        );
        cartItems.clear();
        for (var product in productList) {
          if (cartQuantities.containsKey(product.id.toString())) {
            cartItems.add(product);
          }
        }
        _syncCartItems();
        notifyListeners();
      }
    }catch(e){
      debugPrint("Error loading cart from Firebase: $e");
    }
  }

  int get cartBadgeCount {
    return cartQuantities.values.fold(0, (sum, qty) => sum + qty);
  }

  void increaseQuantity(ProductModel product) {
    final key = product.id.toString();
    cartQuantities[key] = (cartQuantities[key] ?? 1) + 1;
   // cartItems.remove(product);
   // cartItems.insert(0, product);
    saveCart();
    notifyListeners();
  }

  void decreaseQuantity(ProductModel product) {
    final key = product.id.toString();
    final currentQty = cartQuantities[key] ?? 1;

    if (currentQty > 1) {
      cartQuantities[key] = currentQty - 1;
    } else {
      cartItems.remove(product);
      cartQuantities.remove(key);
    }
    saveCart();
    notifyListeners();
  }

  void productRemove(ProductModel product) {
    cartItems.remove(product);
    cartQuantities.remove(product.id.toString());
    saveCart();
    notifyListeners();
  }

  double get subTotal {
    double total = 0.0;
    for (var product in cartItems) {
      int qty = cartQuantities[product.id.toString()] ?? 1;
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
