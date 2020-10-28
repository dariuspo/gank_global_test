import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Styles {
  //color style
  static final Color accentColor = Color(0xFFBBD243);
  static final Color backgroundColor = Color(0xFF0F1620);
  static final Color buttonColor = Color(0xFF6441A5);
  static final Color radarColor = Color(0xFFD35F60);

  static final mainGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.3, 0.6, 1],
    colors: [
      Styles.backgroundColor.withOpacity(1),
      Styles.backgroundColor.withOpacity(0.4),
      Styles.backgroundColor.withOpacity(0.2),
    ],
  );
  //end of color style


  //text style
  static final textButton = TextStyle(
    color: Colors.white,
    fontSize: 40.sp,
    fontWeight: FontWeight.w500,
  );

  //end of text style

  //spacer style

  static SizedBox miniSpace = SizedBox(height: 6.h, width: 6.w);
  static SizedBox smallSpace = SizedBox(height: 12.h, width: 12.w);
  static SizedBox mediumSpace = SizedBox(height: 24.h, width: 24.w);
  static SizedBox bigSpace = SizedBox(height: 40.h);
  static SizedBox hugeSpace = SizedBox(height: 80.h);
  //end of spacer

}