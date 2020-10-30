import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  User currentUser;
  AuthRepository();

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
