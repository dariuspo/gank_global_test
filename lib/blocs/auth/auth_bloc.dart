import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:gank_global_test/blocs/auth/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository _authRepository;

  AuthBloc({@required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository,
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
        yield AuthState.loggedIn();
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
      await _authRepository.login();
      yield AuthState.loggedIn();
    } catch (_) {}
  }
}
