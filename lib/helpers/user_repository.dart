import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gank_global_test/models/gank_user_model.dart';

class UserRepository {
  final _firestoreInstance = FirebaseFirestore.instance;
  CollectionReference _userCollection;
  GankUserModel currentUser;

  UserRepository() {
    _userCollection = _firestoreInstance.collection('users');
  }

  Future<GankUserModel> getAndOrCreateUser(User user) async {
    final doc = await _userCollection.doc(user.uid).get();
    if (doc.data() == null) {
      currentUser =
          GankUserModel(uid: user.uid, name: user.uid.substring(0, 6));
      await saveUser(currentUser);
    } else {
      currentUser = GankUserModel.fromJson(doc.data());
    }
    return currentUser;
  }

  saveUser(GankUserModel gankUser) async {
    _userCollection.doc(gankUser.uid).set(gankUser.toJson());
  }

  /*Future<List<GankUserModel>> getUsers() async {
    QuerySnapshot querySnapshot = await _userCollection.get();
    print("user fetched: ${querySnapshot.docs.length}");
    return querySnapshot.docs.map((e) {
      return GankUserModel.fromJson(e.data());
    }).toList();
  }*/

  Stream<List<GankUserModel>> getUsers(GankUserModel currentUser) async* {
    await for (QuerySnapshot data in _userCollection.snapshots()) {
      final list =
          data.docs.map((doc) => GankUserModel.fromJson(doc.data())).toList();
      list.removeWhere((element) => element.uid == currentUser.uid);
      yield list;
    }
  }
}
