import 'package:flutter/material.dart';
import '../../styles/styles_text.dart';
import '../../styles/styles_color.dart';


class ElevatedRoundButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  ElevatedRoundButton(this.title, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: onPressed,
        padding: EdgeInsets.all(0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
          decoration: BoxDecoration(
              color: StylesColor.accentColor,
              borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            title,
            style: StylesText.button.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
