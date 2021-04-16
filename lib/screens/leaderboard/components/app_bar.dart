import 'package:conquer_bulgaria_app/size_config.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    title: Text(
      'Класация',
      style: TextStyle(
        color: kPrimaryColor,
        fontSize: getProportionateScreenWidth(20),
        fontWeight: FontWeight.w700,
      ),
    ),
    elevation: 10,
  );
}
