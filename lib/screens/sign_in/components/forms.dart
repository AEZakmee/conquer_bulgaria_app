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
      fillColor: kPrimaryColor,
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 45),
      labelText: label,
      labelStyle: TextStyle(color: kPrimaryColor),
      hintText: hint,
      suffixStyle: TextStyle(color: kPrimaryColor),
      suffixIcon: Padding(
        padding: EdgeInsets.only(
          right: getProportionateScreenWidth(20),
        ),
        child: icon,
      ),
    ),
  );
}
