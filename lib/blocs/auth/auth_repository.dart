import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  AuthRepository();

  Future<User> getCurrentUser() async {
    User user = _firebaseAuth.currentUser;
    return user;
  }

  Future<UserCredential> login() async {
    return await _firebaseAuth.signInAnonymously();
  }

  Future<void> logout() async {
    return _firebaseAuth.signOut();
  }
}
