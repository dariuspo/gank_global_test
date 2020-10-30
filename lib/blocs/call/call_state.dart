import 'package:equatable/equatable.dart';

abstract class CallState extends Equatable {
  const CallState();

  @override
  List<Object> get props => [];
}

class InitialState extends CallState {}

class IncomingCall extends CallState {}

class OutgoingCall extends CallState {}
