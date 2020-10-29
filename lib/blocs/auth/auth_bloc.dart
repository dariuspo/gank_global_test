import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gank_global_test/helpers/user_repository.dart';
import 'package:gank_global_test/models/gank_user_model.dart';
import 'package:meta/meta.dart';
import 'package:gank_global_test/blocs/auth/auth_bloc_components.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository _authRepository;
  UserRepository _userRepository;

  AuthBloc({
    @required AuthRepository authRepository,
    @required UserRepository userRepository,
  })  : assert(authRepository != null && userRepository != null),
        _authRepository = authRepository,
        _userRepository = userRepository,
        super(AuthState.empty());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is CheckUser) {
      yield* _mapCheckUserToState();
    } else if (event is Logout) {
      yield* _mapLogoutToState();
    } else if (event is Login) {
      yield* _mapLoginToState();
    }
  }

  Stream<AuthState> _mapCheckUserToState() async* {
    AuthState.check();
    try {
      User user = await _authRepository.getCurrentUser();
      if (user == null) {
        yield AuthState.loggedOut();
      } else {
        GankUserModel gankUserModel =
            await _userRepository.getAndOrCreateUser(user);
        yield AuthState.loggedIn(gankUserModel);
      }
    } catch (_) {
      yield AuthState.loggedOut();
    }
  }

  Stream<AuthState> _mapLogoutToState() async* {
    try {
      await _authRepository.logout();
      yield AuthState.loggedOut();
    } catch (_) {}
  }

  Stream<AuthState> _mapLoginToState() async* {
    try {
      yield AuthState.loading();
      User user = await _authRepository.login();
      GankUserModel gankUserModel =
          await _userRepository.getAndOrCreateUser(user);
      yield AuthState.loggedIn(gankUserModel);
    } catch (_) {}
  }
}
