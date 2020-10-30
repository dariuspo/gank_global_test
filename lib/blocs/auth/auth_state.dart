import 'package:gank_global_test/models/gank_user_model.dart';
import 'package:meta/meta.dart';

@immutable
class AuthState {
  final bool isChecking;
  final bool isLoggedIn;
  final bool isLoggedOut;
  final bool isLoading;
  final GankUserModel user;

  AuthState({
    @required this.isChecking,
    @required this.isLoggedIn,
    @required this.isLoggedOut,
    this.isLoading,
    this.user,
  });

  factory AuthState.empty() {
    return AuthState(
        isLoading: false,
        isChecking: false,
        isLoggedIn: false,
        isLoggedOut: false);
  }

  factory AuthState.check() {
    return AuthState(
        isLoading: false,
        isChecking: true,
        isLoggedIn: false,
        isLoggedOut: false);
  }

  factory AuthState.loggedIn(GankUserModel gankUserModel) {
    return AuthState(
      isLoading: false,
      isChecking: false,
      isLoggedIn: true,
      isLoggedOut: false,
      user: gankUserModel,
    );
  }

  factory AuthState.loggedOut() {
    return AuthState(
        isLoading: false,
        isChecking: false,
        isLoggedIn: false,
        isLoggedOut: true);
  }

  factory AuthState.loading() {
    return AuthState(
      isLoading: true,
      isLoggedIn: false,
      isLoggedOut: false,
      isChecking: false,
    );
  }

  @override
  String toString() {
    return '''AuthState {
      isChecking: $isChecking,
      isLoggedIn: $isLoggedIn,
      isLoggedOut: $isLoggedOut
    }''';
  }
}
