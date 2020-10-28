import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:gank_global_test/blocs/auth/auth_bloc.dart';
import 'package:gank_global_test/blocs/auth/auth_event.dart';
import 'package:gank_global_test/blocs/auth/auth_repository.dart';
import 'package:gank_global_test/blocs/auth/auth_state.dart';
import 'package:gank_global_test/screens/home/home_screen.dart';
import 'package:gank_global_test/screens/home/tabs/cocktail/bloc/bloc.dart';
import 'package:gank_global_test/screens/welcome/welcome_screen.dart';
import 'package:gank_global_test/widgets/animations/circular_progress_widget.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.config(
    defaultTransition: Transition.upToDown,
    defaultDurationTransition: Duration(milliseconds: 250),
  );
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      navigatorKey: Get.key,
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<CocktailRepository>(
            create: (context) => CocktailRepository(),
          ),
          RepositoryProvider<AuthRepository>(
            create: (context) => AuthRepository(),
          ),
        ],
        child: BlocProvider(
          create: (context) =>
              AuthBloc(authRepository: context.repository<AuthRepository>())..add(CheckUser()),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              print(state.isChecking);
              print(state.isLoggedOut);
              return state.isChecking
                  ? CircularProgressWidget()
                  : state.isLoggedOut
                      ? WelcomeScreen()
                      : HomeScreen();
            },
          ),
        ),
      ),
    );
  }
}
