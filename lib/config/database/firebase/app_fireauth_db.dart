import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FireAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on Exception catch (e) {
      if (kDebugMode) print('exception -> $e');
    }
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on Exception catch (e) {
      if (kDebugMode) print('exception -> $e');
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on Exception catch (e) {
      if (kDebugMode) print('exception -> $e');
    }
  }

  String getUid() {
    final dynamic uid = currentUser?.uid;
    return uid;
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on Exception catch (e) {
      if (kDebugMode) print('exception -> $e');
    }
  }
}
