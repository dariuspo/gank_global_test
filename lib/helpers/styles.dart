import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Styles {
  //color style
  static final Color accentColor = Color(0xFFBBD243);
  static final Color backgroundColor = Color(0xFF0F1620);
  static final Color cardColor = Color(0xFF222C35);
  static final Color buttonColor = Color(0xFF6441A5);
  static final Color radarColor = Color(0xFFD35F60);
  static final Color whatsAppColor = Color(0xFF064C44);

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
    fontFamily: fontNameDefault,
    color: Colors.white,
    fontSize: 40.sp,
    fontWeight: FontWeight.w500,
  );

  static final String fontNameDefault = 'Proxima';
  static final String fontNameDefault2 = 'Kaneda';
  static final String fontNameDefaultWA = 'Helveticaneue';

  static final heading1 = TextStyle(
      fontFamily: fontNameDefault,
      color: Colors.black,
      fontSize: 12.sp,
      fontWeight: FontWeight.w300,
      letterSpacing: 1.5..w //-1.5
      );

  static final heading2 = TextStyle(
    fontFamily: fontNameDefault,
    color: Colors.black,
    fontSize: 50.sp,
    fontWeight: FontWeight.w300,
  );

  static final heading3 = heading5.copyWith(
    fontSize: 52.sp,
    fontWeight: FontWeight.w500,
  );

  static final heading4 = heading5.copyWith(
    fontSize: 40.sp,
  );

  static final heading5 = TextStyle(
    fontFamily: Styles.fontNameDefaultWA,
    color: Colors.white,
    fontSize: 32.sp,
    //24
    fontWeight: FontWeight.w800,
    letterSpacing: 1.3,
  );

  static final heading6 = TextStyle(
    fontFamily: fontNameDefault,
    color: Colors.white,
    fontSize: 25.sp,
    fontWeight: FontWeight.w800,
  );

  static final subtitle1 = TextStyle(
    fontFamily: fontNameDefault,
    color: accentColor,
    fontSize: 38.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.sp, //0.15
  );

  static final subtitle2 = TextStyle(
    fontFamily: fontNameDefault,
    color: Colors.white,
    fontSize: 30.sp,
    fontWeight: FontWeight.w800,
    letterSpacing: 3.15.w, //0.15
  );

  static final bodyText1 = TextStyle(
    fontFamily: fontNameDefault2,
    color: accentColor,
    fontSize: 16.sp,
    //16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5.w, //0.5
  );

  static final bodyText2 = TextStyle(
    fontFamily: fontNameDefault,
    color: Colors.black,
    fontSize: 14.sp,
    //14
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25, //0.25
  );

  static final button = TextStyle(
    fontFamily: fontNameDefault,
    color: Colors.black,
    fontSize: 14.sp,
    //14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25.w, //1.25
  );

  //end of text style

  //spacer style

  static SizedBox miniSpace = SizedBox(height: 6, width: 6);
  static SizedBox smallSpace = SizedBox(height: 12, width: 12);
  static SizedBox mediumSpace = SizedBox(height: 24, width: 24);
  static SizedBox bigSpace = SizedBox(
    height: 40,
    width: 40,
  );
  static SizedBox hugeSpace = SizedBox(
    height: 80,
    width: 40,
  );
//end of spacer

}
