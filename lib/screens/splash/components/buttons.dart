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
      height: getProportionateScreenHeight(54),
      child: RoundedLoadingButton(
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
