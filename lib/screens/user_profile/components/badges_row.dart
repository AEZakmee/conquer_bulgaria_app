import 'package:conquer_bulgaria_app/model/chosenUser.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class UserBadges extends StatelessWidget {
  const UserBadges({
    Key key,
    @required this.chosenUser,
  }) : super(key: key);

  final ChosenUser chosenUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: getProportionateScreenHeight(15),
              top: getProportionateScreenWidth(10),
            ),
            child: Text(
              'Постижения',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: getProportionateScreenHeight(19),
                color: kBlueGreenColor,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  chosenUser.badges.length,
                  (index) => Container(
                    height: getProportionateScreenHeight(120),
                    child: Image.asset(
                      chosenUser.badges[index],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: kBlueGreenColor,
          ),
        ],
      ),
    );
  }
}
