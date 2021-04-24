import 'dart:async';
import 'dart:math';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:conquer_bulgaria_app/model/user_location.dart';
import 'package:conquer_bulgaria_app/screens/main_window/components/top_users.dart';
import 'package:conquer_bulgaria_app/screens/places_window/places_window_screen.dart';
import 'package:conquer_bulgaria_app/size_config.dart';
import 'package:conquer_bulgaria_app/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import 'bot_part.dart';
import 'places_cards.dart';
import 'search_field.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String _picture;
  List<TravelLocation> places;
  @override
  void initState() {
    super.initState();
    _picture =
        'assets/images/main_window_background${Random().nextInt(13)}.jpg';
  }

  @override
  Widget build(BuildContext context) {
    places = Provider.of<Data>(context).getMainScreenPlaces;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Image.asset(
                _picture,
              ),
              SearchField(),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(55),
          ),
          if (places != null && places.isNotEmpty)
            TitleSeeAll(
              text: sPlacesMainScreen,
              onClick: () {
                Navigator.pushNamed(context, PlacesWindow.routeName);
              },
            ),
          SizedBox(
            height: getProportionateScreenHeight(
                (places == null || places.isEmpty) ? 220 : 20),
          ),
          if (places != null && places.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                    places.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(12),
                      ),
                      child: PlacesCard(
                        travelLocation: places[index],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(
            height: getProportionateScreenHeight(40),
          ),
          if (Provider.of<Data>(context).topUsers.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(10),
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
                    height: getProportionateScreenHeight(20),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
