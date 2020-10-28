import 'package:flutter/material.dart';
import 'package:gank_global_test/helpers/styles.dart';

class ColorCoverGradientWidget extends StatelessWidget {
  const ColorCoverGradientWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          gradient: Styles.mainGradient,
        ),
      ),
    );
  }
}