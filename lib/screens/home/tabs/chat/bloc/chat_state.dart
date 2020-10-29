import 'package:equatable/equatable.dart';
import 'package:gank_global_test/models/gank_user_model.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class InitialState extends ChatState {}

class LoginState extends ChatState {}

class LoggedIn extends ChatState {
  final Stream<List<GankUserModel>> gankUserModels;

  LoggedIn({this.gankUserModels});

  @override
  List<Object> get props => [gankUserModels];

  @override
  String toString() => 'GameLoaded { games: $gankUserModels }';
}
