import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../strings.dart';

class TitleSeeAll extends StatelessWidget {
  const TitleSeeAll({
    Key key,
    this.text,
    this.onClick,
  }) : super(key: key);
  final String text;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              color: kBoldTextColor,
              fontWeight: FontWeight.w500,
              fontSize: getProportionateScreenWidth(14),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: onClick,
            child: Text(
              sSeeAll,
            ),
          ),
        ],
      ),
    );
  }
}
