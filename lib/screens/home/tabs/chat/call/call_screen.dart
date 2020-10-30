import 'dart:async';
import 'dart:math';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gank_global_test/blocs/auth/auth_bloc_components.dart';
import 'package:gank_global_test/blocs/call/call_bloc_components.dart';
import 'package:gank_global_test/configs/agora_configs.dart';
import 'package:gank_global_test/helpers/styles.dart';
import 'package:gank_global_test/models/call_model.dart';
import 'package:gank_global_test/models/gank_user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  StreamSubscription callStreamSubscription;
  bool muted = false;
  bool noVoice = false;
  RtcEngine engine;

  @override
  void initState() {
    super.initState();
    //addPostFrameCallback();
    initializeAgora();
  }

  addPostFrameCallback() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final callRepository = context.repository<CallRepository>();
      final authRepository = context.repository<AuthRepository>();

      callStreamSubscription = callRepository
          .callStream(uid: authRepository.currentUser.uid)
          .listen((DocumentSnapshot ds) {
        switch (ds.data()) {
          case null:
            Navigator.pop(context);
            break;
          default:
            break;
        }
      });
    });
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
            Styles.smallSpace,
            Text(
              widget.callModel.hasDialled
                  ? widget.callModel.receiverName
                  : widget.callModel.callerName,
              style: Styles.heading5.copyWith(
                fontSize: 52.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
            Styles.smallSpace,
            Text(widget.callModel.hasDialled
                ? _remoteUid != null
                    ? 'Connected'
                    : 'Calling'
                : 'Connected', style: Styles.heading5,),
            Expanded(
              flex: 7,
              child: Center(
                child: CircularProfileAvatar(
                  '',
                  radius: 300.w,
                  backgroundColor: Colors.primaries[1],
                  initialsText: Text(
                    widget.callModel.hasDialled
                        ? widget.callModel.receiverName[0]
                        : widget.callModel.callerName[0],
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipOval(
                    child: Material(
                      color: Colors.red, // button color
                      child: InkWell(
                        child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(
                              noVoice ? Icons.volume_off : Icons.volume_up,
                              color: Colors.white,
                            )),
                        onTap: () async {
                          _onToggleVoice();
                        },
                      ),
                    ),
                  ),
                  ClipOval(
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
                          context
                              .repository<CallRepository>()
                              .endCall(call: widget.callModel);
                        },
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      color: Colors.red, // button color
                      child: InkWell(
                        child: SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(
                              muted ? Icons.mic_off : Icons.mic,
                              color: Colors.white,
                            )),
                        onTap: () async {
                          _onToggleMute();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    engine.muteLocalAudioStream(muted);
  }

  void _onToggleVoice() {
    setState(() {
      noVoice = !noVoice;
    });
    engine.muteAllRemoteAudioStreams(noVoice);
  }

  @override
  void dispose() {
    //callStreamSubscription.cancel();
    engine?.leaveChannel();
    engine?.destroy();
    super.dispose();
  }
}
