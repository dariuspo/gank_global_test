import 'dart:async';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:gank_global_test/helpers/utils.dart';
import 'package:gank_global_test/models/message_model.dart';
import 'package:rxdart/rxdart.dart';

class ChatRepository {
  AgoraRtmClient _client;
  Map<String, BehaviorSubject<List<MessageModel>>> mapStreamChat = {};
  String currentUid;

  BehaviorSubject<List<MessageModel>> getMapStreamChat(String uid) {
    print('uid detail $uid');
    initMapStream(uid);
    return mapStreamChat[uid];
  }

  init() async {
    _client =
        await AgoraRtmClient.createInstance('1f528117448648b6b897fd2d0966ddc8');
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

  initMapStream(String peerId){
    if (mapStreamChat[peerId] == null) {
      print('map stream null');
      mapStreamChat[peerId] = BehaviorSubject()..add([]);
    }
  }
  addReceivedMessageToStream(String text, String toUid){
    initMapStream(toUid);
    List<MessageModel> messages = [];
    messages.addAll(mapStreamChat[toUid].value);

    messages.add(MessageModel(
        message: text, dateTime: DateTime.now(), fromUid: toUid));
    print(messages.length);

    mapStreamChat[toUid].add(messages);
  }
  addMessageToStream(String text, String toUid, String fromUid){
    initMapStream(toUid);
    List<MessageModel> messages = [];
    messages.addAll(mapStreamChat[toUid].value);
    messages.add(MessageModel(
        message: text, dateTime: DateTime.now(), fromUid: fromUid));

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
