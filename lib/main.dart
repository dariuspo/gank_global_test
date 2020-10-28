import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide Transition;
import 'package:gank_global_test/screens/home/home_screen.dart';
import 'package:gank_global_test/screens/home/tabs/cocktail/bloc/bloc.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.config(
    defaultTransition: Transition.upToDown,
    defaultDurationTransition: Duration(milliseconds: 250),
  );
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
      home: RepositoryProvider(
        create: (context) => CocktailRepository(),
        child: HomeScreen(),
      ),
    );
  }
}
