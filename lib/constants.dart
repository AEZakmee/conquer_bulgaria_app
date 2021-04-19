import 'package:flutter/material.dart';
import 'size_config.dart';

//TODO: BETTER COLORS
const kPrimaryColor = Color(0xffc82a00);
const kAccentColor = Colors.white;
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Colors.blueGrey;
const kBoxColor = Color(0xFF3E4067);
const kBoldTextColor = Colors.black;
const kCoolFont = 'aAlwaysSmile';

const kAnimationDuration = Duration(milliseconds: 200);
final kHeadingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
final kBoxShadow = BoxShadow(
  offset: Offset(3, 3),
  blurRadius: 5,
  color: Colors.black.withOpacity(0.3),
);
OutlineInputBorder kSearchOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.transparent),
  gapPadding: 10,
);
OutlineInputBorder kOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(28),
  borderSide: BorderSide(color: kTextColor),
  gapPadding: 10,
);
