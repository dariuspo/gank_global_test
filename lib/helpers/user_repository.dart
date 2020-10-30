import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gank_global_test/models/gank_user_model.dart';

class UserRepository {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  GankUserModel currentUser;

  //this method to handle new user or only get user data
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

  //save new user
  saveUser(GankUserModel gankUser) async {
    _userCollection.doc(gankUser.uid).set(gankUser.toJson());
  }

  //get list users to chat with
  Stream<List<GankUserModel>> getUsers(GankUserModel currentUser) async* {
    await for (QuerySnapshot data
        in _userCollection.orderBy('lastLogin', descending: true).snapshots()) {
      final list =
          data.docs.map((doc) => GankUserModel.fromJson(doc.data())).toList();
      list.removeWhere((element) => element.uid == currentUser.uid);
      yield list;
    }
  }
}
