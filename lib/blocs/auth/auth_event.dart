import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckUser extends AuthEvent {}

class Logout extends AuthEvent {}

class Login extends AuthEvent {}
