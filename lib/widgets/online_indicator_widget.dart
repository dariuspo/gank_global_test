import 'package:flutter/material.dart';
import 'package:gank_global_test/models/gank_user_model.dart';
import 'package:gank_global_test/screens/home/tabs/chat/bloc/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnlineIndicatorWidget extends StatelessWidget {
  const OnlineIndicatorWidget({
    Key key,
    @required this.gankUserModel,
    this.showText = false,
  }) : super(key: key);

  final GankUserModel gankUserModel;
  final bool showText;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future:
            context.repository<ChatRepository>().isOnline(gankUserModel.uid),
        builder: (context, snapShotFuture) {
          if (snapShotFuture.connectionState == ConnectionState.waiting) {
            return CircleAvatar(
              backgroundColor: Colors.white,
              radius: 8,
              child: CircleAvatar(
                radius: 6,
                backgroundColor: Colors.blue,
              ),
            );
          } else if (snapShotFuture.hasData) {
            return CircleAvatar(
              backgroundColor: Colors.white,
              radius: 8,
              child: CircleAvatar(
                radius: 6,
                backgroundColor:
                    snapShotFuture.data ? Colors.green : Colors.red,
              ),
            );
          }
          return SizedBox.shrink();
        });
  }
}
