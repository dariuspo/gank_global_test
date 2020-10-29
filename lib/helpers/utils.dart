import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gank_global_test/helpers/styles.dart';

class Utils {
  static showToast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Styles.accentColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}