import 'package:equatable/equatable.dart';
import 'package:gank_global_test/models/gank_user_model.dart';

abstract class CallState extends Equatable {
  const CallState();

  @override
  List<Object> get props => [];
}

class InitialState extends CallState {}

class IncomingCall extends CallState {}

class OutgoingCall extends CallState {}
