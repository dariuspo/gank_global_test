import 'dart:convert';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:gank_global_test/helpers/utils.dart';

class ChatRepository {
  AgoraRtmClient _client;

  init() async {
    _client =
        await AgoraRtmClient.createInstance('1f528117448648b6b897fd2d0966ddc8');
    print(_client);
    _client.onMessageReceived = (AgoraRtmMessage message, String peerId) {

      print("Peer msg: " + peerId + ", msg: " + message.text);
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

  agoraLogin(String uid) async {
    try {
      await init();
      await _client.login(null, uid);
    } catch (errorCode) {
      print(uid);
      print(errorCode);
      Utils.showToast('Can\'t login to agora');
    }
  }
}
