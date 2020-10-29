import 'package:flutter/material.dart';
import 'package:gank_global_test/helpers/styles.dart';
import 'package:gank_global_test/models/call_model.dart';

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
      body: Center(child: Text('incoming call'),),
    );
  }
}
