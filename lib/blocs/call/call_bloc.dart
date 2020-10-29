import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank_global_test/blocs/call/call_bloc_components.dart';
import 'package:gank_global_test/helpers/user_repository.dart';
import 'package:gank_global_test/models/call_model.dart';
import 'package:gank_global_test/models/gank_user_model.dart';
import 'package:gank_global_test/screens/home/tabs/chat/bloc/chat_repository.dart';
import 'package:gank_global_test/screens/home/tabs/chat/call/call_screen.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  final ChatRepository _chatRepository;
  final UserRepository _userRepository;
  final CallRepository _callRepository;

  StreamController<List<GankUserModel>> _usersStream = BehaviorSubject();

  CallBloc({
    @required ChatRepository chatRepository,
    @required UserRepository userRepository,
    @required CallRepository callRepository,
  })  : assert(chatRepository != null && userRepository != null && callRepository !=null),
        _chatRepository = chatRepository,
        _userRepository = userRepository,
        _callRepository = callRepository,
      super(InitialState());

  @override
  Stream<CallState> mapEventToState(
    CallEvent event,
  ) async* {
    if (event is StartCall) {
      CallModel callModel = CallModel(
        callerId: event.userFrom.uid,
        callerName: event.userFrom.name,
        receiverId: event.userTo.uid,
        receiverName: event.userTo.name,
        channelId: Random().nextInt(1000).toString(),
      );
      bool callMade = await _callRepository.makeCall(call: callModel);
      callModel.hasDialled = true;

      if (callMade) {
        // enter log
        Get.to(CallScreen(callModel: callModel,));
      }
    }
    if (event is EndCall) {}
  }

  void dispose() {
    _usersStream.close();
  }
}
