import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/strings.dart';
import 'package:flutter/material.dart';

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
      child: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavItem(
                icon: Icons.place,
                title: sPlaces,
                press: () {},
              ),
              NavItem(
                icon: Icons.chat,
                title: sChat,
                press: () {},
              ),
              NavItem(
                icon: Icons.people,
                title: sUsers,
                press: () {},
              ),
            ],
          ),
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
    this.isActive = false,
  }) : super(key: key);
  final String title;
  final GestureTapCallback press;
  final bool isActive;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(5),
        height: getProportionateScreenWidth(50),
        width: getProportionateScreenWidth(60),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [if (isActive) kBoxShadow],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: kPrimaryColor,
            ),
            Spacer(),
            Text(
              title,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(13),
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
