import 'package:flutter/material.dart';
import 'package:gank_global_test/helpers/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ElevatedRoundButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  ElevatedRoundButton(this.title, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 60.h, horizontal: 200.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.w)),
      color: Styles.buttonColor,
      onPressed: onPressed,
      child: Text(
        title,
        style: Styles.textButton,
      ),
    );
  }
}
