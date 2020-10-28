import 'package:meta/meta.dart';

@immutable
class AuthState {
  final bool isChecking;
  final bool isLoggedIn;
  final bool isLoggedOut;
  final bool isLoading;

  AuthState({
    @required this.isChecking,
    @required this.isLoggedIn,
    @required this.isLoggedOut,
    this.isLoading,
  });

  factory AuthState.empty() {
    return AuthState(isChecking: false, isLoggedIn: false, isLoggedOut: false);
  }

  factory AuthState.check() {
    return AuthState(isChecking: true, isLoggedIn: false, isLoggedOut: false);
  }

  factory AuthState.loggedIn() {
    return AuthState(isChecking: false, isLoggedIn: true, isLoggedOut: false);
  }

  factory AuthState.loggedOut() {
    return AuthState(isChecking: false, isLoggedIn: false, isLoggedOut: true);
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
