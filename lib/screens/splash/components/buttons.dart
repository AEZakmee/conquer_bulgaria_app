import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../strings.dart';
import 'package:flutter/material.dart';

class DefaultLoadingButton extends StatelessWidget {
  const DefaultLoadingButton({
    Key key,
    this.text = sContinue,
    @required this.onPress,
    this.color = kPrimaryColor,
    this.controller,
  }) : super(key: key);
  final String text;
  final Function onPress;
  final Color color;
  final RoundedLoadingButtonController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      //height: getProportionateScreenHeight(54),
      child: RoundedLoadingButton(
        height: getProportionateScreenHeight(54),
        controller: controller,
        color: color,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: getProportionateScreenWidth(20),
          ),
        ),
        onPressed: onPress,
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text = sContinue,
    @required this.onPress,
    this.color = kPrimaryColor,
    this.size,
  }) : super(key: key);
  final String text;
  final Function onPress;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? double.infinity,
      height: getProportionateScreenHeight(54),
      child: Material(
        color: color,
        elevation: color == kPrimaryColor ? 5 : 0,
        borderRadius: BorderRadius.circular(30),
        child: MaterialButton(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: getProportionateScreenWidth(20),
            ),
          ),
          onPressed: onPress,
        ),
      ),
    );
  }
}
