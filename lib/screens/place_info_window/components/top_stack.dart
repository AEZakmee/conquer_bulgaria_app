import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conquer_bulgaria_app/model/cached_image.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class TopStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomRight,
      children: [
        Container(
          child: SizedBox(
            height: getProportionateScreenHeight(340),
            child: CustomCachedImage(
              travelLocation: Provider.of<Data>(context).chosenLocation,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(getProportionateScreenWidth(80)),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: getProportionateScreenHeight(-60),
          child: Container(
            height: getProportionateScreenHeight(100),
            width: getProportionateScreenWidth(290),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  getProportionateScreenWidth(25),
                ),
                bottomLeft: Radius.circular(
                  getProportionateScreenWidth(25),
                ),
              ),
              boxShadow: [kBoxShadow],
            ),
            child: RatingsRow(
              travelLocation: Provider.of<Data>(context).chosenLocation,
            ),
          ),
        )
      ],
    );
  }
}

class RatingsRow extends StatelessWidget {
  const RatingsRow({
    Key key,
    this.travelLocation,
  }) : super(key: key);
  final TravelLocation travelLocation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // SizedBox(
        //   height: getProportionateScreenHeight(100),
        // ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Icon(
                      Icons.star,
                      color: Color(0xffffd814),
                    ),
                  ),
                ),
                Text(
                  travelLocation.ratings.length != 0
                      ? (travelLocation.ratings.reduce(
                                      (value, element) => value + element) /
                                  travelLocation.ratings.length)
                              .toStringAsFixed(1) +
                          '/5'
                      : 'Няма гласове',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
                if (travelLocation.ratings.length != 0)
                  Text('${travelLocation.ratings.length} глас' +
                      ((travelLocation.ratings.length == 1) ? '' : 'а'))
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Icon(
                      Icons.star_border,
                      color: Color(0xffffd814),
                      size: getProportionateScreenWidth(40),
                    ),
                  ),
                ),
                AutoSizeText(
                  (Provider.of<Data>(context)
                          .currentUser
                          .places
                          .contains(travelLocation.id))
                      ? 'Гласувай'
                      : 'Посети, за да гласуваш',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: getProportionateScreenWidth(11),
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: FittedBox(
                      child: Icon(
                        Icons.navigation,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      'Навигация',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: getProportionateScreenWidth(13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
