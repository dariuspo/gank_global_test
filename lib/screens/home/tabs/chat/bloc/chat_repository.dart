import 'dart:async';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gank_global_test/configs/agora_configs.dart';
import 'package:gank_global_test/helpers/utils.dart';
import 'package:gank_global_test/models/message_model.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class ChatRepository {
  final CollectionReference messagesCollection =
      FirebaseFirestore.instance.collection("messages");

  AgoraRtmClient _client;
  Map<String, BehaviorSubject<List<MessageModel>>> mapStreamChat = {};

  //Map<String, BehaviorSubject<List<MessageModel>>> mapStreamChat = {};

  String currentUid;

  Future<BehaviorSubject<List<MessageModel>>> getMapStreamChat(
      String currentUserUid, String uid) async {
    await initMapStream(uid);
    return mapStreamChat[uid];
  }

  init() async {
    //initialize agora here
    _client = await AgoraRtmClient.createInstance(APP_ID);
    //detect when there is incoming messages
    _client.onMessageReceived = (AgoraRtmMessage message, String fromUid) {
      String channelId = Utils.getChatRoomId(currentUid, fromUid);

      if (currentOpenChannelId == channelId) {
        //markMessageAsRead(channelId);
      } else {
        Get.snackbar('new message from ${fromUid.substring(0, 6)}', message.text,
            colorText: Colors.white);
      }
      addReceivedMessageToStream(message.text, fromUid);

      print("Peer msg: " + fromUid + ", msg: " + message.text);
    };
    //detect connection change
    _client.onConnectionStateChanged = (int state, int reason) {
      print('Connection state changed: ' +
          state.toString() +
          ', reason: ' +
          reason.toString());
    };
  }

  //init map stream to get stream of chats
  Future<bool> initMapStream(String peerId) async {
    if (mapStreamChat[peerId] == null) {
      mapStreamChat[peerId] = BehaviorSubject();
      List<MessageModel> messages =
          await getMessage(Utils.getChatRoomId(currentUid, peerId));
      mapStreamChat[peerId].add(messages ?? []);
      return true;
    }
    return false;
  }

  //get message saved in firebase for persistent message
  Future<List<MessageModel>> getMessage(String channelId) async {
    QuerySnapshot querySnapshot = await messagesCollection
        .orderBy("dateTime", descending: false)
        .where('channelId', isEqualTo: channelId)
        .get();
    final list =
        querySnapshot.docs.map((e) => MessageModel.fromJson(e.data())).toList();
    return list;
  }

  //this method handle incoming message
  addReceivedMessageToStream(String text, String toUid) async {
    bool isFirstTime = await initMapStream(toUid);
    if (isFirstTime) return;
    List<MessageModel> messages = [];
    messages.addAll(mapStreamChat[toUid].value);
    messages.add(
        MessageModel(message: text, dateTime: DateTime.now(), fromUid: toUid));
    mapStreamChat[toUid].add(messages);
  }

  //this method handle outcoming messages
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
    messages.add(messageModel);
    messagesCollection.doc().set(messageModel.toJson());
    mapStreamChat[toUid].add(messages);
  }

  sendMessage(String text, String toUid, String fromUid) async {
    addMessageToStream(text, toUid, fromUid);
    try {
      AgoraRtmMessage message = AgoraRtmMessage.fromText(text);
      await _client.sendMessageToPeer(toUid, message, false);
      print('Send peer message success.');
    } catch (errorCode) {
      //Utils.showToast('failed to send to $toUid he is offline');
      print('Send peer message error: ' + errorCode.toString());
    }
  }

  //login agora
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
      print(response[uid]);
      return response[uid];
    } catch (e) {}
    return false;
  }

  //get list users to chat with
  Stream<MessageModel> getLatestMessage(String channelId) async* {
    print('listen to $channelId');
    await for (QuerySnapshot data in messagesCollection
        .orderBy("dateTime", descending: true)
        .where('channelId', isEqualTo: channelId)
        .limit(1)
        .snapshots()) {
      print('new snapshot ${data.docs.length}');
      if(data.docs.isNotEmpty){
        final list = data.docs.map((doc) => MessageModel.fromJson(doc.data())).toList();
        yield list[0];
      }
    }
  }

  dispose() {
    mapStreamChat.values.forEach((element) => element.close());
  }
}
