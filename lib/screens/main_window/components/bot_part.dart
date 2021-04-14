import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../strings.dart';

class TitleSeeAll extends StatelessWidget {
  const TitleSeeAll(
      {Key key, @required this.text, this.onClick, this.hasSeeAllButton = true})
      : super(key: key);
  final String text;
  final bool hasSeeAllButton;
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
              fontWeight: FontWeight.w800,
              fontSize: getProportionateScreenHeight(18),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: hasSeeAllButton ? onClick : () {},
            child: Text(
              (hasSeeAllButton) ? sSeeAll : '',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: getProportionateScreenHeight(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
