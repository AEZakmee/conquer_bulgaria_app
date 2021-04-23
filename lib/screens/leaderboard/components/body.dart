import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/user_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'leaderboard_entry.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...List.generate(
              Provider.of<Data>(context).topUsers.length,
              (index) {
                User user = Provider.of<Data>(context).topUsers[index];
                //print(user.totalPlaces);
                return Padding(
                  padding:
                      EdgeInsets.only(top: getProportionateScreenHeight(8)),
                  child: TopUser(
                    index: index,
                    name: user.username,
                    points: user.totalPlaces,
                    isCurrentUser: (user.username ==
                        Provider.of<Data>(context).currentUser.username),
                  ),
                );
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(40),
            ),
          ],
        ),
      ),
    );
  }
}

// class UsersRow extends StatelessWidget {
//   const UsersRow({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.blueGrey.shade100,
//           boxShadow: [kBoxShadow],
//           borderRadius: BorderRadius.circular(13),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//           child: Column(
//             children: [
//               ...List.generate(
//                 Provider.of<Data>(context).topUsers.length,
//                 (index) {
//                   User user = Provider.of<Data>(context).topUsers[index];
//                   return Padding(
//                     padding: EdgeInsets.only(
//                         bottom: getProportionateScreenHeight(8)),
//                     child: TopUser(
//                       index: index,
//                       name: user.username,
//                       points: user.totalPlaces,
//                       isCurrentUser: (user.username ==
//                           Provider.of<Data>(context).currentUser.username),
//                     ),
//                   );
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class TopUser extends StatelessWidget {
//   const TopUser({
//     Key key,
//     this.points,
//     this.name,
//     this.index,
//     this.isCurrentUser = false,
//   }) : super(key: key);
//   final int points;
//   final String name;
//   final int index;
//   final bool isCurrentUser;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       //padding: EdgeInsets.all(getProportionateScreenWidth(10)),
//       width: SizeConfig.screenWidth - 30,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [kBoxShadow],
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: SizedBox(
//         height: getProportionateScreenHeight(55),
//         child: Row(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(
//                   left: getProportionateScreenHeight(15),
//                   right: getProportionateScreenHeight(10)),
//               child: buildText(string: (index + 1).toString(), size: 25),
//             ),
//             VerticalDivider(
//               color: Colors.blueGrey.shade600,
//               thickness: 2,
//             ),
//             Padding(
//               padding: EdgeInsets.only(left: getProportionateScreenHeight(5)),
//               child: buildText(
//                   string: name,
//                   size: 18,
//                   color: (isCurrentUser) ? Colors.red : Colors.black87),
//             ),
//             Spacer(),
//             Padding(
//               padding: EdgeInsets.only(right: getProportionateScreenWidth(15)),
//               child: buildText(string: points.toString(), size: 23),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Text buildText(
//       {String string, double size = 17, Color color = Colors.black87}) {
//     return Text(
//       string,
//       style: TextStyle(
//           color: color,
//           fontWeight: FontWeight.bold,
//           fontSize: getProportionateScreenWidth(size)),
//     );
//   }
// }
