import 'dart:async';
import 'dart:math';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gank_global_test/configs/agora_configs.dart';
import 'package:gank_global_test/helpers/styles.dart';
import 'package:gank_global_test/models/call_model.dart';
import 'package:gank_global_test/models/gank_user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallScreen extends StatefulWidget {
  final CallModel callModel;

  const CallScreen({Key key, this.callModel}) : super(key: key);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final rnd = new Random();
  bool _joined = false;
  int _remoteUid;

  RtcEngine engine;
  @override
  void initState() {
    super.initState();
    initializeAgora();
  }

  Future<void> initializeAgora() async {
    engine = await RtcEngine.create(APP_ID);
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('joinChannelSuccess $channel $uid');
          setState(() {
            _joined = true;
          });
        }, userJoined: (int uid, int elapsed) {
      print('userJoined $uid');
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      print('userOffline $uid');
      setState(() {
        _remoteUid = null;
      });
    }));
    await engine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    await engine.joinChannel(null, widget.callModel.channelId, null, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.whatsAppColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock,
              size: 13,
              color: Colors.white54,
            ),
            Styles.miniSpace,
            Text(
              'End-to-end encrypted',
              style: TextStyle(color: Colors.white54, fontSize: 14),
            )
          ],
        ),
      ),
      backgroundColor: Styles.whatsAppColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.callModel.receiverName),
            Styles.smallSpace,
            Text('Calling'),
            Expanded(
              flex: 7,
              child: Center(
                child: CircularProfileAvatar(
                  '',
                  radius: 300.w,
                  backgroundColor: Colors.primaries[rnd.nextInt(10 - 0)],
                  initialsText: Text(
                    widget.callModel.receiverName[0],
                    style: TextStyle(fontSize: 200.sp, color: Colors.white),
                  ),
                  elevation: 5.0,
                  cacheImage: true,
                  showInitialTextAbovePicture: true,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: ClipOval(
                  child: Material(
                    color: Colors.red, // button color
                    child: InkWell(
                      child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.phone_disabled,
                            color: Colors.white,
                          )),
                      onTap: () async {

                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
