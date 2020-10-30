import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:gank_global_test/blocs/auth/auth_bloc.dart';
import 'package:gank_global_test/blocs/auth/auth_event.dart';
import 'package:gank_global_test/blocs/auth/auth_repository.dart';
import 'package:gank_global_test/blocs/auth/auth_state.dart';
import 'package:gank_global_test/blocs/call/call_bloc_components.dart';
import 'package:gank_global_test/helpers/user_repository.dart';
import 'package:gank_global_test/screens/home/home_screen.dart';
import 'package:gank_global_test/screens/home/tabs/chat/bloc/chat_bloc.dart';
import 'package:gank_global_test/screens/home/tabs/chat/bloc/chat_bloc_components.dart';
import 'package:gank_global_test/screens/home/tabs/chat/bloc/chat_repository.dart';
import 'package:gank_global_test/screens/home/tabs/cocktail/bloc/cocktail_bloc_components.dart';
import 'package:gank_global_test/screens/welcome/welcome_screen.dart';
import 'package:gank_global_test/widgets/animations/circular_progress_widget.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.config(
    defaultTransition: Transition.rightToLeft,
    defaultDurationTransition: Duration(milliseconds: 250),
  );
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CocktailRepository>(
          create: (context) => CocktailRepository(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider<ChatRepository>(
          create: (context) => ChatRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider<CallRepository>(
          create: (context) => CallRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.repository<AuthRepository>(),
              userRepository: context.repository<UserRepository>(),
            )..add(CheckUser()),
          ),
          BlocProvider(
            create: (context) => ChatBloc(
              chatRepository: context.repository<ChatRepository>(),
              userRepository: context.repository<UserRepository>(),
            ),
          ),
          BlocProvider(
            lazy: false,
            create: (context) => CallBloc(
              authRepository: context.repository<AuthRepository>(),
              callRepository: context.repository<CallRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          themeMode: ThemeMode.dark,
          navigatorKey: Get.key,
          home: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state.isLoggedIn) {
                //listen to call data and login to agora once loggedin
                BlocProvider.of<ChatBloc>(context).add(LoginAgora(state.user));
                BlocProvider.of<CallBloc>(context).add(Called());
              }
            },
            builder: (context, state) {
              //detect user auth status
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
