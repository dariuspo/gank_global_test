import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gank_global_test/helpers/user_repository.dart';
import 'package:gank_global_test/models/gank_user_model.dart';
import 'package:gank_global_test/screens/home/tabs/chat/bloc/chat_bloc_components.dart';
import 'package:gank_global_test/screens/home/tabs/chat/bloc/chat_repository.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;
  final UserRepository _userRepository;

  ChatBloc(
      {@required ChatRepository chatRepository, @required UserRepository userRepository})
      : assert(chatRepository != null, userRepository != null),
        _chatRepository = chatRepository,
        _userRepository =userRepository,
        super(InitialState());

  @override
  Stream<ChatState> mapEventToState(ChatEvent event,) async* {
    if (event is LoginAgora) {
      await _chatRepository.agoraLogin(event.gankUserModel.uid);
      /*List<GankUserModel> gankUserModel =
      yield LoggedIn(gankUserModels:);*/
    }
  }
}
