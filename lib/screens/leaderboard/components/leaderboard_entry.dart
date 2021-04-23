import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/screens/user_profile/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class TopUser extends StatelessWidget {
  const TopUser({
    Key key,
    this.points,
    this.name,
    this.index,
    this.isCurrentUser = false,
  }) : super(key: key);
  final int points;
  final String name;
  final int index;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<Data>(context, listen: false).setChosenUser(index);
        Navigator.pushNamed(context, UserProfile.routeName);
      },
      child: Container(
        //padding: EdgeInsets.all(getProportionateScreenWidth(10)),
        width: SizeConfig.screenWidth - 30,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [kBoxShadow],
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          height: getProportionateScreenHeight(calculateHeightForPos(index)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (index < 3)
                Expanded(
                  flex: 3,
                  child: Hero(
                    tag: 'assets${index + 1}',
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Image.asset('assets/images/${index + 1}_place.png'),
                    ),
                  ),
                ),
              if (index >= 3)
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(30),
                    ),
                    child: Text(
                      (index + 1).toString() + '.',
                      style: TextStyle(
                        fontSize: getProportionateScreenHeight(24),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              if (index < 3)
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildName(
                          name: name.split(' ')[0],
                          index: index,
                          isYou: isCurrentUser),
                      buildName(
                          name: name.split(' ')[1] ?? '',
                          index: index,
                          isYou: isCurrentUser),
                    ],
                  ),
                ),
              if (index >= 3)
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildName(name: name, index: index, isYou: isCurrentUser),
                    ],
                  ),
                ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: getProportionateScreenWidth(5),
                    left: getProportionateScreenWidth(5),
                  ),
                  child: Text(
                    points.toString(),
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(
                          calculateHeightForPoints(index)),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FittedBox buildName({String name, int index, bool isYou = false}) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        name,
        style: TextStyle(
          color: isYou ? kPrimaryColor : Colors.blueGrey,
          fontWeight: FontWeight.w800,
          fontSize:
              getProportionateScreenHeight(calculateHeightForPoints(index) - 3),
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  double calculateHeightForPos(int index) {
    if (index == 0)
      return 90;
    else if (index == 1)
      return 85;
    else if (index == 2) return 75;
    return 55;
  }

  double calculateHeightForPoints(int index) {
    if (index == 0)
      return 34;
    else if (index == 1)
      return 26;
    else if (index == 2) return 23;
    return 22;
  }
}
