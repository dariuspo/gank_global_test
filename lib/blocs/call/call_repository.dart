import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gank_global_test/models/call_model.dart';
import 'package:gank_global_test/models/message_model.dart';

class CallRepository {
  final CollectionReference callCollection =
      FirebaseFirestore.instance.collection("call");


  Stream<DocumentSnapshot> callStream({String uid}) =>
      callCollection.doc(uid).snapshots();

  Future<bool> makeCall({CallModel call}) async {
    try {
      call.hasDialled = true;
      Map<String, dynamic> hasDialledMap = call.toJson();

      call.hasDialled = false;
      Map<String, dynamic> hasNotDialledMap = call.toJson();

      await callCollection.doc(call.callerId).set(hasDialledMap);
      await callCollection.doc(call.receiverId).set(hasNotDialledMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }


  Future<bool> endCall({CallModel call}) async {
    try {
      await callCollection.doc(call.callerId).delete();
      await callCollection.doc(call.receiverId).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
