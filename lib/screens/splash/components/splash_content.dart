import '../../../size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: SvgPicture.asset(
            image,
            height: getProportionateScreenHeight(300),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
