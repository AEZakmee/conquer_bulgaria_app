import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:conquer_bulgaria_app/screens/leaderboard/leaderboard_screen.dart';
import 'package:conquer_bulgaria_app/screens/places_window/places_window_screen.dart';
import 'package:conquer_bulgaria_app/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';
import '../../size_config.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Colors.white60,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              icon: Icons.place,
              title: sPlaces,
              press: () {
                Navigator.pushNamed(context, PlacesWindow.routeName);
              },
            ),
            NavItem(
              icon: Icons.leaderboard,
              title: 'Класация',
              press: () {
                Navigator.pushNamed(context, LeaderBoardWindow.routeName);
              },
            ),
            // NavItem(
            //   icon: Icons.local_activity,
            //   title: 'load',
            //   press: () async {
            //     final String response =
            //         await rootBundle.loadString('assets/places.json');
            //     final data = await json.decode(response);
            //     List<TravelLocation> locs = [];
            //     print(data['places'].forEach((v) {
            //       locs.add(TravelLocation.fromJson(v));
            //     }));
            //     for (int i = 0; i < locs.length; i++) {
            //       //await Future.delayed(Duration(seconds: 3));
            //       Firestore.instance
            //           .collection('places')
            //           .document(locs[i].id.toString())
            //           .setData(locs[i].toMap());
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.press,
  }) : super(key: key);
  final String title;
  final GestureTapCallback press;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenHeight(5)),
        height: getProportionateScreenHeight(56),
        width: getProportionateScreenWidth(100),
        child: Column(
          children: [
            Flexible(
              child: Icon(
                icon,
                color: kPrimaryColor,
              ),
            ),
            Spacer(),
            AutoSizeText(
              title,
              style: TextStyle(
                //fontSize: getProportionateScreenWidth(13),
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}
