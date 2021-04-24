import 'package:conquer_bulgaria_app/model/chosenUser.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class UserInfoBox extends StatelessWidget {
  const UserInfoBox({
    Key key,
    @required this.chosenUser,
  }) : super(key: key);

  final ChosenUser chosenUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth - 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
        ),
        boxShadow: [kBoxShadow],
      ),
      child: Padding(
        padding: EdgeInsets.all(
          getProportionateScreenHeight(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chosenUser.userData.username,
              style: TextStyle(
                color: kBoldTextColor,
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenHeight(26),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Text(
              'Посетени обекти: ${chosenUser.userData.totalPlaces}',
              style: TextStyle(
                color: kBlueGreenColor,
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenHeight(18),
              ),
            ),
            Text(
              'Оценени обекти: ${chosenUser.userData.votedPlaces.length - 1}',
              style: TextStyle(
                color: kBlueGreenColor,
                fontWeight: FontWeight.bold,
                fontSize: getProportionateScreenHeight(18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
