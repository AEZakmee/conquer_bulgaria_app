import 'dart:math';

import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/screens/main_window/components/top_users.dart';
import 'package:conquer_bulgaria_app/screens/places_window/places_window_screen.dart';
import 'package:conquer_bulgaria_app/size_config.dart';
import 'package:conquer_bulgaria_app/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bot_part.dart';
import 'places_cards.dart';
import 'search_field.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/main_window_background${Random().nextInt(9)}.jpg',
              ),
              SearchField(),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(55),
          ),
          TitleSeeAll(
            text: sPlacesMainScreen,
            onClick: () {
              Navigator.pushNamed(context, PlacesWindow.routeName);
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...List.generate(
                  Provider.of<Data>(context).placesLength,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(12),
                    ),
                    child: PlacesCard(
                      travelLocation:
                          Provider.of<Data>(context).demoPlaces[index],
                      onClick: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          TitleSeeAll(
            text: sTopUsers,
            hasSeeAllButton: false,
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          UsersRow(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
        ],
      ),
    );
  }
}
