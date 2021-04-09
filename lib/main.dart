import 'package:conquer_bulgaria_app/screens/main_window/main_window_screen.dart';

import 'routes.dart';
import 'strings.dart';
import 'theme.dart';
import 'package:flutter/material.dart';

import 'screens/splash/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: sName,
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
