import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/screens/loading_screen/loading_window.dart';
import 'package:provider/provider.dart';
import 'routes.dart';
import 'strings.dart';
import 'theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Data()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: sName,
        theme: theme(),
        initialRoute: //MainWindow.routeName,
            //SplashScreen.routeName,
            LoadingScreen.routeName,
        routes: routes,
      ),
    );
  }
}
