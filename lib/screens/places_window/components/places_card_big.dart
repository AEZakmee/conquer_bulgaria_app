import 'package:conquer_bulgaria_app/model/cached_image.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:conquer_bulgaria_app/screens/place_info_window/place_info_screen.dart';
import 'package:conquer_bulgaria_app/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class BigPlacesCard extends StatelessWidget {
  const BigPlacesCard({
    Key key,
    @required this.travelLocation,
  }) : super(key: key);
  final TravelLocation travelLocation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          Provider.of<Data>(context, listen: false)
              .setChosenLocation(travelLocation);
          Navigator.pushNamed(context, PlacesInfoWindow.routeName);
        },
        child: Container(
          width: getProportionateScreenWidth(160),
          decoration: BoxDecoration(
            boxShadow: [kBoxShadow],
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: travelLocation.id,
                child: SizedBox(
                  height: getProportionateScreenHeight(150),
                  child: CustomCachedImage(
                    travelLocation: travelLocation,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  travelLocation.name,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kBoldTextColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                child: Text(
                  travelLocation.town,
                ),
              ),
              (Provider.of<Data>(context)
                      .currentUser
                      .places
                      .contains(travelLocation.id))
                  ? buildPlaceVisited(isVisited: true)
                  : buildPlaceVisited(isVisited: false)
            ],
          ),
          //height: getProportionateScreenHeight(120),
        ),
      ),
    );
  }

  Widget buildPlaceVisited({bool isVisited}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            (isVisited) ? sVisitedPlace : sNotVisitedPlace,
            style: TextStyle(
                fontSize: (isVisited)
                    ? getProportionateScreenWidth(14)
                    : getProportionateScreenWidth(11),
                color: (isVisited) ? Colors.green : Colors.red,
                fontWeight: FontWeight.w800),
          ),
          (isVisited)
              ? Icon(
                  Icons.check,
                  color: Colors.green,
                )
              : Icon(
                  Icons.close,
                  color: Colors.red,
                ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Text(
              calculateRangeString(travelLocation.range),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  String calculateRangeString(double range) {
    if (range == null) return '';
    if (range > 1000) return '>1000км';
    if (range > 1) return range.toStringAsFixed(1) + 'км';
    //print(range);
    if (range > 0) return (range * 100).toStringAsFixed(0) + 'м';
    return '';
  }
}
