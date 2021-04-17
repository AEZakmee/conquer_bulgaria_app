import 'package:auto_size_text/auto_size_text.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:conquer_bulgaria_app/model/user_location.dart';
import 'package:conquer_bulgaria_app/screens/others/cached_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
          bottom: getProportionateScreenHeight(-35),
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
            padding: travelLocation.ratings.length != 0
                ? EdgeInsets.all(6.0)
                : EdgeInsets.all(14),
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
                FittedBox(
                  child: Text(
                    travelLocation.ratings.length != 0
                        ? (travelLocation.ratings.reduce(
                                        (value, element) => value + element) /
                                    travelLocation.ratings.length)
                                .toStringAsFixed(1) +
                            '/5'
                        : 'Няма гласове',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                if (travelLocation.ratings.length != 0)
                  Text('${travelLocation.ratings.length} глас' +
                      ((travelLocation.ratings.length == 1) ? '' : 'а'))
              ],
            ),
          ),
        ),
        VotingStar(
          travelLocation: travelLocation,
          voted: Provider.of<Data>(context)
              .currentUser
              .votedPlaces
              .contains(travelLocation.id),
        ),
        Expanded(
          child: InkWell(
            onTap: () async {
              UserLocation ul =
                  Provider.of<Data>(context, listen: false).currentUserLocation;
              //https://stackoverflow.com/questions/15042283/current-location-google-maps-link-to-directions
              String url;
              if (ul == null) {
                url =
                    'https://www.google.com/maps?saddr=My+Location&daddr=${travelLocation.latitude},${travelLocation.longitude}';
              } else {
                url =
                    'https://www.google.com/maps?saddr=${ul.latitude},${ul.longitude}&daddr=${travelLocation.latitude},${travelLocation.longitude}';
              }
              await launch(url);
            },
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

class VotingStar extends StatelessWidget {
  const VotingStar({
    Key key,
    @required this.travelLocation,
    this.voted = false,
  }) : super(key: key);

  final TravelLocation travelLocation;
  final bool voted;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: (!voted &&
                Provider.of<Data>(context)
                    .currentUser
                    .places
                    .contains(travelLocation.id))
            ? () {
                print('voting');
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: FittedBox(
                  child: Icon(
                    voted ? Icons.tag_faces : Icons.star_border,
                    color: Color(0xffffd814),
                    size: getProportionateScreenWidth(40),
                  ),
                ),
              ),
              voted
                  ? AutoSizeText(
                      'Вотът ви е запаметен',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: getProportionateScreenWidth(11),
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    )
                  : AutoSizeText(
                      (Provider.of<Data>(context)
                              .currentUser
                              .places
                              .contains(travelLocation.id))
                          ? 'Гласувай'
                          : 'Посети, за да гласуваш',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Provider.of<Data>(context)
                                .currentUser
                                .places
                                .contains(travelLocation.id)
                            ? getProportionateScreenWidth(14)
                            : getProportionateScreenWidth(11),
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
