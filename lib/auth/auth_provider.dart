import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app/model/user_model.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:typed_data';

class AuthhProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? get currentUser => _auth.currentUser;
  bool get isLoggedIn => _auth.currentUser != null;
  String? userName;
  String? userPhone;
  String? userEmail;
  String? userImage;
  String? userCreatedAt;

  AuthhProvider() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        loadUserData();
      }
    });
  }

  Future<void> signInWithGoogle() async{
    try{
      UserCredential userCredential;
      if(kIsWeb){
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider.addScope('email');
        googleProvider.addScope('profile');
        googleProvider.setCustomParameters({'prompt': 'select_account'});
        userCredential = await _auth.signInWithPopup(googleProvider);

      }else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        if(googleUser == null){
          return;
        }

        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await _auth.signInWithCredential(credential);
      }

      final User? user = userCredential.user;
      if(user != null){
        final docRef = _firestore.collection('users').doc(user.uid);
        final doc = await docRef.get();

        if(!doc.exists){
          final String signupDate = DateFormat('dd MMM yyyy').format(DateTime.now());
          await docRef.set({
            'name' : user.displayName ?? '',
            'email' : user.email ?? '',
            'phone' : user.phoneNumber ?? '',
            'profileImage' : user.photoURL ?? '',
            'createdAt' : signupDate,
            'onboardDate' : signupDate,
            'favorites' : [],
            'cart' : {},
            'addresses' : [],
            'cards' : [],
            'transaction' : [],
            'searchHistory' : []
          });
        }
        await loadUserData();
        notifyListeners();
      }
    } on FirebaseAuthException catch (e){
     throw Exception(_getFriendlyErrorMessage(e.code));
    }catch(e){
    //  debugPrint("Google Sign-in Error: $e");
      throw Exception("Failed to signIn with google. Please try again");
    }
  }

  String _getFriendlyErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered. Please login instead.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password. Please try again.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'weak-password':
        return 'Password is too weak. Must be at least 6 characters.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'network-request-failed':
        return 'No internet connection. Please check your network.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }

  Future<void> signup({
    required String name,
    required String email,
    required String contact,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user != null) {
        final String signupDate = DateFormat('dd MMM yyyy').format(DateTime.now());

        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'phone': contact,
          'createdAt': signupDate,
          'onboardDate': signupDate,
          'favorites' : [],
          'cart' : {},
          'addresses' : [],
          'cards' : [],
          'transaction' : [],
          'searchHistory' : []
        });

        userName = name;
        userPhone = contact;
        userEmail = email;
        userCreatedAt = signupDate;
      }

      notifyListeners();
    } on FirebaseAuthException catch (e) {
      throw Exception(_getFriendlyErrorMessage(e.code));
    } catch (e) {
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }

  Future<void> loadUserData() async {
    try {
      User? user = _auth.currentUser;

      if (user == null) {
        return;
      }

      DocumentSnapshot snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        userName = data['name'];
        userPhone = data['phone'] ?? data['contact'];
        userEmail = data['email'];
        userImage = data['profileImage'];
        userCreatedAt = data['createdAt'] ?? data['onboardDate'] ?? '';
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Load User Data Error: $e");
    }
  }

  Future<void> updateProfileImage(Uint8List bytes) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      final base64String = base64Encode(bytes);

      await _firestore.collection('users').doc(user.uid).update({
        'profileImage': base64String,
      });
      userImage = base64String;
      notifyListeners();
    } catch (e) {
      debugPrint("Update Profile image error: $e");
    }
  }

  Future<void> updateUserData({
    required String name,
    required String phone,
  }) async {
    try {
      final user = _auth.currentUser;

      if (user == null) return;

      await _firestore.collection('users').doc(user.uid).update({
        'name': name,
        'phone': phone,
      });

      // Update Provider values immediately
      userName = name;
      userPhone = phone;

      notifyListeners();
    } catch (e) {
      debugPrint("Update User Data Error: $e");
      rethrow;
    }
  }

  Future<void> signin(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      await loadUserData();
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      throw Exception(_getFriendlyErrorMessage(e.code));
    } catch (e) {
      throw Exception("An unexpected error occurred. Please try again.");
    }
  }

  Future<void> logout() async {
    try {
      if (!kIsWeb) {
        await _googleSignIn.signOut();
      }
    }catch(e){
      debugPrint("Google Sign Out Error: $e");
    }

    try{
      await _auth.signOut();
    }catch(e){
      debugPrint("Firebase Signout Error: $e");
    }

    userName = null;
    userEmail = null;
    userPhone = null;
    userImage = null;
    userCreatedAt = null;
    notifyListeners();
  }

  UserModel get user => UserModel(
    uid: _auth.currentUser?.uid ?? '',
    name: userName ?? '',
    email: userEmail ?? '',
    phone: userPhone ?? '',
    createdAt: userCreatedAt ?? '',
  );
}
