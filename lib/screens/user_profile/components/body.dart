import 'package:auto_size_text/auto_size_text.dart';
import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/model/chosenUser.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:conquer_bulgaria_app/screens/others/cached_image.dart';
import 'package:conquer_bulgaria_app/screens/place_info_window/place_info_screen.dart';
import 'package:conquer_bulgaria_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'badges_row.dart';
import 'user_box.dart';
import 'visited_places.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfoBox(chosenUser: Provider.of<Data>(context).chosenUser),
          if (Provider.of<Data>(context).chosenUser.badges.isNotEmpty)
            UserBadges(
              chosenUser: Provider.of<Data>(context).chosenUser,
            ),
          if (Provider.of<Data>(context).chosenUser.userData.places.isNotEmpty)
            VisitedPlaceColumn(
              chosenUser: Provider.of<Data>(context).chosenUser,
            ),
        ],
      ),
    );
  }
}
