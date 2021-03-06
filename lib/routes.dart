import 'package:conquer_bulgaria_app/screens/leaderboard/leaderboard_screen.dart';
import 'package:conquer_bulgaria_app/screens/loading_screen/loading_window.dart';
import 'package:conquer_bulgaria_app/screens/user_profile/user_profile_screen.dart';

import 'screens/main_window/main_window_screen.dart';
import 'screens/place_info_window/place_info_screen.dart';
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
  PlacesInfoWindow.routeName: (context) => PlacesInfoWindow(),
  LoadingScreen.routeName: (context) => LoadingScreen(),
  LeaderBoardWindow.routeName: (context) => LeaderBoardWindow(),
  UserProfile.routeName: (context) => UserProfile(),
};
