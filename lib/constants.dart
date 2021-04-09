import 'package:flutter/material.dart';
import 'size_config.dart';

//TODO: BETTER COLORS
const kPrimaryColor = Color(0xff34eb83);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF979797), Colors.blueGrey],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kBoldTextColor = Colors.black;
const kCoolFont = 'aAlwaysSmile';

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
