import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/screens/main_window/main_window_screen.dart';
import 'package:conquer_bulgaria_app/size_config.dart';
import 'package:provider/provider.dart';

import 'routes.dart';
import 'screens/splash/splash_screen.dart';
import 'strings.dart';
import 'theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Data(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: sName,
        theme: theme(),
        initialRoute: MainWindow.routeName,
        //SplashScreen.routeName,
        routes: routes,
      ),
    );
  }
}
