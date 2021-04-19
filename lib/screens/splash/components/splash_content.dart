import 'package:auto_size_text/auto_size_text.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key key,
    this.text,
    this.image,
    this.title,
  }) : super(key: key);
  final String text, image, title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Image.asset(
              image,
              height: getProportionateScreenHeight(300),
            ),
          ),
        ),
        SizedBox(
          width: SizeConfig.screenWidth,
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kBoldTextColor,
              fontSize: getProportionateScreenHeight(20),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: AutoSizeText(
              text,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: getProportionateScreenHeight(17),
              ),
              maxLines: 5,
            ),
          ),
        ),
      ],
    );
  }
}
