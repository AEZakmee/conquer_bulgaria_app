import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';

class UsersRow extends StatelessWidget {
  const UsersRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ...List.generate(
            3,
            (index) {
              User user;
              int currIndex = index;
              if (index == 0) {
                user = Provider.of<Data>(context).topUsers[index + 1];
                currIndex = index + 1;
              } else if (index == 1) {
                user = Provider.of<Data>(context).topUsers[index - 1];
                currIndex = index - 1;
              } else
                user = Provider.of<Data>(context).topUsers[index];
              return TopPlace(
                flex: index == 1 ? 5 : 4,
                index: currIndex,
                name: user.username,
                points: user.totalPlaces,
                isCurrentUser: (user.username ==
                    Provider.of<Data>(context).currentUser.username),
              );
            },
          )
        ],
      ),
    );
  }
}

class TopPlace extends StatelessWidget {
  const TopPlace({
    Key key,
    this.flex,
    this.index,
    this.name,
    this.points,
    this.isCurrentUser,
  }) : super(key: key);
  final int flex;
  final int index;
  final String name;
  final int points;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          padding: EdgeInsets.all(8),
          // height: index == 1
          //     ? getProportionateScreenHeight(180)
          //     : getProportionateScreenHeight(120),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [kBoxShadow],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                buildName(name: name.split(' ')[0], index: index),
                buildName(name: name.split(' ')[1], index: index),
                // Container(
                //   width: SizeConfig.screenWidth / 3,
                //   child: FittedBox(
                //     child: Image.asset('assets/images/1_place.png'),
                //     //fit: BoxFit.fitWidth,
                //   ),
                // ),
                SizedBox(
                  height: getProportionateScreenHeight(7),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(9)),
                  child: Image.asset('assets/images/${index + 1}_place.png'),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    points.toString() + ' Точки',
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w800,
                        fontSize: (index == 0)
                            ? getProportionateScreenWidth(19)
                            : getProportionateScreenWidth(14)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  FittedBox buildName({String name, int index}) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        name,
        style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: (index == 0)
                ? getProportionateScreenWidth(19)
                : getProportionateScreenWidth(14)),
      ),
    );
  }
}

//children: [
//   ...List.generate(
//     Provider.of<Data>(context).topUsers.length,
//     (index) => TopUser(
//       imageUrl: Provider.of<Data>(context).topUsers[index].picture,
//       name: Provider.of<Data>(context).topUsers[index].username,
//       points: Provider.of<Data>(context).topUsers[index].totalPlaces,
//     ),
//   )
// ],
