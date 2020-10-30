import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  User currentUser;

  AuthRepository() {
    _firebaseAuth.authStateChanges().listen((user) async {
      if (user != null) {
        await _userCollection.doc(user.uid).set(
          {'lastLogin': Timestamp.fromDate(DateTime.now())},
          SetOptions(merge: true),
        );
      }
    });
  }

  Future<User> getCurrentUser() async {
    User user = _firebaseAuth.currentUser;
    currentUser = user;
    return currentUser;
  }

  Future<User> login() async {
    UserCredential userCredential = await _firebaseAuth.signInAnonymously();
    currentUser = userCredential.user;
    return currentUser;
  }

  Future<void> logout() async {
    return _firebaseAuth.signOut();
  }
}
