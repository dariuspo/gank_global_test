import 'package:bubble/bubble.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gank_global_test/blocs/auth/auth_bloc_components.dart';
import 'package:gank_global_test/blocs/call/call_bloc.dart';
import 'package:gank_global_test/blocs/call/call_bloc_components.dart';
import 'package:gank_global_test/helpers/styles.dart';
import 'package:gank_global_test/helpers/extensions.dart';

import 'package:gank_global_test/helpers/user_repository.dart';
import 'package:gank_global_test/models/gank_user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gank_global_test/models/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank_global_test/screens/home/tabs/chat/bloc/chat_bloc.dart';
import 'package:gank_global_test/screens/home/tabs/chat/bloc/chat_repository.dart';
import 'package:gank_global_test/screens/home/tabs/chat/call/call_screen.dart';
import 'package:gank_global_test/widgets/animations/circular_progress_widget.dart';
import 'package:gank_global_test/widgets/online_indicator_widget.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class ChatDetailScreen extends StatefulWidget {
  final GankUserModel chatWithUser;
  final int index;

  ChatDetailScreen({Key key, @required this.chatWithUser, this.index = 0})
      : super(key: key);

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  GankUserModel currentUser;
  ScrollController scrollController = ScrollController();
  bool isFirstScrollDone = false;

  @override
  void initState() {
    // TODO: implement initState
    /*SchedulerBinding.instance.addPostFrameCallback((_){
      print(scrollController.position.maxScrollExtent);
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });*/
    currentUser = context.repository<UserRepository>().currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(scrollController.position.maxScrollExtent);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styles.cardColor,
        title: Row(
          children: [
            CircularProfileAvatar(
              '',
              radius: 40.w,
              backgroundColor: Colors.primaries[widget.index],
              initialsText: Text(
                widget.chatWithUser.name[0],
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              elevation: 5.0,
              cacheImage: true,
              showInitialTextAbovePicture: true,
            ),
            Styles.smallSpace,
            Text(widget.chatWithUser.name, style: Styles.heading4),
            Styles.smallSpace,
            OnlineIndicatorWidget(
              gankUserModel: widget.chatWithUser,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: IconButton(
                icon: Icon(Icons.call),
                onPressed: () {
                  context.bloc<CallBloc>()
                    ..add(StartCall(
                        userTo: widget.chatWithUser, userFrom: currentUser));
                  //Get.to(CallScreen(chatWithUser: widget.chatWithUser));
                }),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Styles.backgroundColor,
          image: DecorationImage(
              image: AssetImage("assets/images/wa_bg.png"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<BehaviorSubject<List<MessageModel>>>(
                future: context.repository<ChatRepository>().getMapStreamChat(
                    context.repository<AuthRepository>().currentUser.uid,
                    widget.chatWithUser.uid),
                builder: (context, snapshot) {
                  print(snapshot.connectionState);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressWidget();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    print('bild stream builder ${snapshot.data.value.length}');
                    return StreamBuilder<List<MessageModel>>(
                      stream: snapshot.data,
                      builder: (context, snapshotStream) {
                        DateTime currentDate;
                        print('snapshot data ${snapshotStream.data}');
                        if (snapshotStream.hasData) {
                          print('snapshot has data');
                          if (!isFirstScrollDone) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              scrollController.jumpTo(
                                scrollController.position.maxScrollExtent,
                              );
                              isFirstScrollDone = true;
                            });
                          }
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListView(
                              reverse: false,
                              controller: scrollController,
                              children:
                                  snapshotStream.data.mapIndexed((e, index) {
                                bool showDate;
                                MessageModel messageModel =
                                    snapshotStream.data[index];
                                if (currentDate == null) {
                                  currentDate = messageModel.dateTime;
                                  showDate = true;
                                } else if (!currentDate
                                    .isSameDay(messageModel.dateTime)) {
                                  showDate = true;
                                  currentDate = messageModel.dateTime;
                                } else {
                                  showDate = false;
                                }
                                bool isFromMe =
                                    messageModel.fromUid == currentUser.uid;
                                return Column(
                                  children: [
                                    if (showDate)
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Styles.cardColor,
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 10,
                                        ),
                                        child: Text(
                                          messageModel.dateTime
                                              .toChatDateLabel(),
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                    Align(
                                      alignment: isFromMe
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Bubble(
                                        margin: BubbleEdges.only(top: 10),
                                        color: isFromMe
                                            ? Styles.whatsAppColor
                                            : Styles.cardColor,
                                        nip: isFromMe
                                            ? BubbleNip.rightTop
                                            : BubbleNip.leftTop,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                messageModel.message,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Styles.miniSpace,
                                              Text(
                                                messageModel.dateTime.toHhMm(),
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
            InputTextChat(
              chatWithUser: widget.chatWithUser,
              scrollController: scrollController,
            )
          ],
        ),
      ),
    );
  }
}

class InputTextChat extends StatefulWidget {
  final GankUserModel chatWithUser;
  final ScrollController scrollController;

  const InputTextChat({Key key, this.chatWithUser, this.scrollController})
      : super(key: key);

  @override
  _InputTextChatState createState() => _InputTextChatState();
}

class _InputTextChatState extends State<InputTextChat> {
  final TextEditingController textEditingController = TextEditingController();
  GankUserModel currentUser;

  @override
  void initState() {
    // TODO: implement initState

    currentUser = context.repository<UserRepository>().currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Styles.cardColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: textEditingController,
                textInputAction: TextInputAction.newline,
                onChanged: (_) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: "Type a message",
                  hintStyle: TextStyle(color: Colors.white54),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white, fontSize: 42.sp),
                minLines: 1,
                maxLines: 3,
                showCursor: true,
                cursorColor: Styles.accentColor,
              ),
            ),
          ),
          Styles.miniSpace,
          ClipOval(
            child: Material(
              color: textEditingController.text.isEmpty
                  ? Colors.grey
                  : Styles.accentColor, // button color
              child: InkWell(
                child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    )),
                onTap: () async {
                  if (textEditingController.text.isEmpty) {
                    return;
                  }
                  //should be use bloc, but for this project it's okay
                  await context.repository<ChatRepository>().sendMessage(
                      textEditingController.text,
                      widget.chatWithUser.uid,
                      currentUser.uid);
                  textEditingController.text = '';
                  setState(() {});
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => {
                      widget.scrollController.animateTo(
                        widget.scrollController.position.maxScrollExtent + 30,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn,
                      )
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
