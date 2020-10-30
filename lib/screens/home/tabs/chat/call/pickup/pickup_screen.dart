import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gank_global_test/blocs/call/call_bloc_components.dart';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank_global_test/helpers/styles.dart';
import 'package:gank_global_test/models/call_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gank_global_test/screens/home/tabs/chat/call/call_screen.dart';
import 'package:get/get.dart';

class PickupScreen extends StatefulWidget {
  final CallModel callModel;

  const PickupScreen({Key key, this.callModel}) : super(key: key);

  @override
  _PickupScreenState createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
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
      body: Column(
        children: [
          Container(
            color: Styles.whatsAppColor,
            child: Center(
              child: Column(
                children: [
                  CircularProfileAvatar(
                    '',
                    radius: 120.w,
                    backgroundColor: Colors.primaries[Random().nextInt(10 - 0)],
                    initialsText: Text(
                      widget.callModel.callerName[0],
                      style: TextStyle(fontSize: 80.sp, color: Colors.white),
                    ),
                    elevation: 5.0,
                    cacheImage: true,
                    showInitialTextAbovePicture: true,
                  ),
                  Styles.mediumSpace,
                  Text(widget.callModel.callerName, style: Styles.heading3,),
                  Styles.mediumSpace,
                  Text(
                    'Whatsapp voice call',
                    style: Styles.heading5.copyWith(fontStyle: FontStyle.italic),
                  ),
                  Styles.mediumSpace,
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(bottom: 100.h),
              color: Styles.backgroundColor,
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipOval(
                    child: Material(
                      color: Color(0xFF09D262), // button color
                      child: InkWell(
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () async {
                          Get.to(CallScreen(
                            callModel: widget.callModel,
                          ));
                        },
                      ),
                    ),
                  ),
                  ClipOval(
                    child: Material(
                      color: Colors.red, // button color
                      child: InkWell(
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: Icon(
                            Icons.phone_disabled,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () async {
                          context
                              .repository<CallRepository>()
                              .endCall(call: widget.callModel);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
