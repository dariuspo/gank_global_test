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
    color: Colors.white,
    fontSize: 40.sp,
    fontWeight: FontWeight.w500,
  );

  //end of text style

  //spacer style

  static SizedBox miniSpace = SizedBox(height: 6, width: 6);
  static SizedBox smallSpace = SizedBox(height: 12, width: 12);
  static SizedBox mediumSpace = SizedBox(height: 24, width: 24);
  static SizedBox bigSpace = SizedBox(height: 40, width: 40,);
  static SizedBox hugeSpace = SizedBox(height: 80, width: 40,);
  //end of spacer

}
