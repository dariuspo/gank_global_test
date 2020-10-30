import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gank_global_test/helpers/styles.dart';

class Utils {
  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Styles.accentColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static String getChatRoomId(String user1, String user2) {
    if (user1.compareTo(user2) == 1) {
      return "$user1-$user2";
    } else {
      return "$user2-$user1";
    }
  }
}
