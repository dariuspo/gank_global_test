import 'dart:async';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gank_global_test/configs/agora_configs.dart';
import 'package:gank_global_test/helpers/utils.dart';
import 'package:gank_global_test/models/message_model.dart';
import 'package:rxdart/rxdart.dart';

class ChatRepository {
  final CollectionReference messagesCollection =
      FirebaseFirestore.instance.collection("messages");

  AgoraRtmClient _client;
  Map<String, BehaviorSubject<List<MessageModel>>> mapStreamChat = {};
  String currentUid;

  Future<BehaviorSubject<List<MessageModel>>> getMapStreamChat(
      String currentUserUid, String uid) async {
    await initMapStream(uid);
    return mapStreamChat[uid];
  }

  init() async {
    _client = await AgoraRtmClient.createInstance(APP_ID);
    print(_client);
    _client.onMessageReceived = (AgoraRtmMessage message, String fromUid) {
      addReceivedMessageToStream(message.text, fromUid);
      print("Peer msg: " + fromUid + ", msg: " + message.text);
    };
    _client.onConnectionStateChanged = (int state, int reason) {
      print('Connection state changed: ' +
          state.toString() +
          ', reason: ' +
          reason.toString());
      if (state == 5) {
        /*_client.logout();
        _log('Logout.');
        setState(() {
          _isLogin = false;
        });*/
      }
    };
  }

  initMapStream(String peerId) async {
    if (mapStreamChat[peerId] == null) {
      print('map stream null');
      print(Utils.getChatRoomId(currentUid, peerId));
      List<MessageModel> messages =
          await getMessage(Utils.getChatRoomId(currentUid, peerId));
      print('after get messages');
      print(messages.length);
      mapStreamChat[peerId] = BehaviorSubject();
      mapStreamChat[peerId].add(messages ?? []);
    }
  }

  Future<List<MessageModel>> getMessage(String channelId) async {
    QuerySnapshot querySnapshot = await messagesCollection
        .orderBy("dateTime", descending: true)
        .where('channelId', isEqualTo: channelId)
        .get();
    final list =
        querySnapshot.docs.map((e) => MessageModel.fromJson(e.data())).toList();
    print(list.length);
    return list;
  }

  addReceivedMessageToStream(String text, String toUid) async{
    await initMapStream(toUid);
    List<MessageModel> messages = [];
    messages.addAll(mapStreamChat[toUid].value);

    messages.insert(0,
        MessageModel(message: text, dateTime: DateTime.now(), fromUid: toUid));
    print(messages.length);
    mapStreamChat[toUid].add(messages);
  }

  addMessageToStream(String text, String toUid, String fromUid) async {
    await initMapStream(toUid);
    List<MessageModel> messages = [];
    messages.addAll(mapStreamChat[toUid].value);
    MessageModel messageModel = MessageModel(
      message: text,
      dateTime: DateTime.now(),
      fromUid: fromUid,
      channelId: Utils.getChatRoomId(
        fromUid,
        toUid,
      ),
    );
    messages.insert(0, messageModel);
    messagesCollection.doc().set(messageModel.toJson());
    mapStreamChat[toUid].add(messages);
  }

  sendMessage(String text, String toUid, String fromUid) async {
    try {
      AgoraRtmMessage message = AgoraRtmMessage.fromText(text);
      print(message.text);
      await _client.sendMessageToPeer(toUid, message, false);
      print('Send peer message success.');
      addMessageToStream(message.text, toUid, fromUid);
      print('Send peer message success.');
    } catch (errorCode) {
      print('Send peer message error: ' + errorCode.toString());
    }
  }

  agoraLogin(String uid) async {
    try {
      currentUid = uid;
      await init();
      await _client.login(null, uid);
    } catch (errorCode) {
      print(errorCode);
      Utils.showToast('Can\'t login to agora');
    }
  }

  Future<bool> isOnline(String uid) async {
    try {
      Map<String, dynamic> response =
          await _client.queryPeersOnlineStatus([uid]);
      return response[uid];
    } catch (e) {}
    return false;
  }

  dispose() {
    mapStreamChat.values.forEach((element) => element.close());
  }
}
