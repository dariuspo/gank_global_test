import 'package:flutter/material.dart';
import 'package:gank_global_test/helpers/styles.dart';

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Styles.accentColor),
      ),
    );
  }
}
