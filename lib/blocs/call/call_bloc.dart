import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank_global_test/blocs/auth/auth_bloc_components.dart';
import 'package:gank_global_test/blocs/call/call_bloc_components.dart';
import 'package:gank_global_test/helpers/user_repository.dart';
import 'package:gank_global_test/models/call_model.dart';
import 'package:gank_global_test/models/gank_user_model.dart';
import 'package:gank_global_test/screens/home/tabs/chat/bloc/chat_repository.dart';
import 'package:gank_global_test/screens/home/tabs/chat/call/call_screen.dart';
import 'package:gank_global_test/screens/home/tabs/chat/call/pickup/pickup_screen.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  final AuthRepository _authRepository;
  final CallRepository _callRepository;

  StreamController<List<GankUserModel>> _usersStream = BehaviorSubject();

  CallBloc({
    @required AuthRepository authRepository,
    @required CallRepository callRepository,
  })  : assert(authRepository != null && callRepository != null),
        _authRepository = authRepository,
        _callRepository = callRepository,
        super(InitialState());

  @override
  Stream<CallState> mapEventToState(
    CallEvent event,
  ) async* {
    if (event is Called) {
      print('bloc initial state');

      _callRepository
          .callStream(uid: _authRepository.currentUser.uid)
          .listen((event) {
        print('from bloc listener ${event.data()}');
        if (event.data() != null) {
          print('from bloc listener');
          CallModel call = CallModel.fromJson(event.data());
          if (!call.hasDialled) {
            Get.to(PickupScreen(callModel: call));
          }
        }else {
          Get.back();
        }
      });
    }
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
        Get.to(CallScreen(
          callModel: callModel,
        ));
      }
    }
  }

  void dispose() {
    _usersStream.close();
  }
}
