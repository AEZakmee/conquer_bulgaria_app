import 'screens/main_window/main_window_screen.dart';
import 'screens/places_window/places_window_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';
import 'screens/sign_in/sign_up_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  MainWindow.routeName: (context) => MainWindow(),
  PlacesWindow.routeName: (context) => PlacesWindow(),
};
