import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gank_global_test/models/gank_user_model.dart';

class UserRepository {
  final _firestoreInstance = FirebaseFirestore.instance;
  CollectionReference _userCollection;

  UserRepository() {
    _userCollection = _firestoreInstance.collection('users');
  }

  Future<GankUserModel> getAndOrCreateUser(User user) async {
    final doc = await _userCollection.doc(user.uid).get();
    if (doc.data() == null) {
      final gankUser = GankUserModel(uid: user.uid, name: user.uid.substring(0, 6));
      await saveUser(gankUser);
      return gankUser;
    }
    return GankUserModel.fromJson(doc.data());
  }

  saveUser(GankUserModel gankUser) async {
    _userCollection.doc(gankUser.uid).set(gankUser.toJson());
  }

  Future<List<GankUserModel>> getCategories() async {
    QuerySnapshot querySnapshot =
    await _quoteCollection.where('isActive', isEqualTo: true).get();
    logger.i("quotes fetched: ${querySnapshot.docs.length}");
    return querySnapshot.docs.map((e) {
      return Category.fromJson(e.data());
    }).toList();
  }

}