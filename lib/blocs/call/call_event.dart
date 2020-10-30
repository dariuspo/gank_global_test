import 'package:equatable/equatable.dart';
import 'package:gank_global_test/models/gank_user_model.dart';

abstract class CallEvent extends Equatable {
  const CallEvent();

  @override
  List<Object> get props => [];
}

class StartCall extends CallEvent {
  final GankUserModel userFrom;
  final GankUserModel userTo;

  StartCall({this.userFrom, this.userTo});
}

class Called extends CallEvent {}
