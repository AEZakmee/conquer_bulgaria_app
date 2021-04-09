import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

Widget customFormField({
  String label,
  String hint,
  Icon icon,
  TextEditingController myController,
}) {
  return TextFormField(
    showCursor: true,
    controller: myController,
    cursorColor: kPrimaryColor,
    obscureText: label == 'Password' ? true : false,
    decoration: InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      enabledBorder: kOutlineInputBorder,
      focusedBorder: kOutlineInputBorder,
      border: kOutlineInputBorder,
      fillColor: kPrimaryColor,
      labelStyle: TextStyle(color: kPrimaryColor),
      suffixStyle: TextStyle(color: kPrimaryColor),
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
      labelText: label,
      hintText: hint,
      suffixIcon: Padding(
        padding: EdgeInsets.only(
          right: getProportionateScreenWidth(20),
        ),
        child: icon,
      ),
    ),
  );
}
