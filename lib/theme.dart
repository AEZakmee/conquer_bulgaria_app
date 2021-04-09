import 'package:flutter/material.dart';
import 'constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    brightness: Brightness.light,
    primarySwatch: Colors.grey,
    primaryColor: kPrimaryColor,
    primaryColorBrightness: Brightness.light,
    accentColor: kAccentColor,
    accentColorBrightness: Brightness.light,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: kPrimaryColor,
      labelStyle: TextStyle(color: kPrimaryColor),
      suffixStyle: TextStyle(color: kPrimaryColor),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.black, fontSize: 18),
    ),
  );
}
