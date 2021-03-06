import 'package:equatable/equatable.dart';
import 'package:gank_global_test/models/gank_user_model.dart';
import 'package:gank_global_test/models/message_model.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class LoginAgora extends ChatEvent {
  final GankUserModel gankUserModel;

  LoginAgora(this.gankUserModel);

  @override
  List<Object> get props => [gankUserModel];
}

class FetchChats extends ChatEvent {}

class SendMessage extends ChatEvent {
  final MessageModel message;
  final String peerUid;

  SendMessage(this.message, this.peerUid);
}
