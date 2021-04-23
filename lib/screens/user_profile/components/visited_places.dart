import 'package:auto_size_text/auto_size_text.dart';
import 'package:conquer_bulgaria_app/model/chosenUser.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:conquer_bulgaria_app/screens/others/cached_image.dart';
import 'package:conquer_bulgaria_app/screens/place_info_window/place_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class VisitedPlaceColumn extends StatelessWidget {
  const VisitedPlaceColumn({
    Key key,
    this.chosenUser,
  }) : super(key: key);
  final ChosenUser chosenUser;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: SizeConfig.screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenHeight(15),
                top: getProportionateScreenWidth(10),
              ),
              child: Text(
                'Посетени обекти',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: getProportionateScreenHeight(19),
                  color: kBlueGreenColor,
                ),
              ),
            ),
            Wrap(
              alignment: WrapAlignment.spaceAround,
              children: [
                SizedBox(
                  width: double.infinity,
                ),
                ...List.generate(
                  chosenUser.userData.places.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenHeight(12),
                      horizontal: getProportionateScreenWidth(5),
                    ),
                    child: PlaceCard(
                      chosenUser: chosenUser,
                      travelLocation: Provider.of<Data>(context)
                          .places[chosenUser.userData.places[index] - 1],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    Key key,
    @required this.chosenUser,
    this.travelLocation,
  }) : super(key: key);

  final ChosenUser chosenUser;
  final TravelLocation travelLocation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<Data>(context, listen: false)
            .setChosenLocation(travelLocation);
        Navigator.pushNamed(context, PlacesInfoWindow.routeName);
      },
      child: Container(
        width: getProportionateScreenWidth(110),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CustomCachedImage(
                travelLocation: travelLocation,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                hasShadow: true,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [kBoxShadow],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              width: getProportionateScreenWidth(110),
              //height: getProportionateScreenHeight(55),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    AutoSizeText(
                      travelLocation.name,
                      maxLines: chosenUser.isCurrentUser ? 2 : 3,
                    ),
                    if (chosenUser.isCurrentUser)
                      VotedRow(
                        isVoted: chosenUser.userData.votedPlaces
                            .contains(travelLocation.id),
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class VotedRow extends StatelessWidget {
  const VotedRow({Key key, this.isVoted}) : super(key: key);
  final bool isVoted;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeText(
          'Оценено',
          style: TextStyle(
            color: (isVoted) ? Colors.green : Colors.red,
            fontWeight: FontWeight.w800,
          ),
          maxLines: 1,
        ),
        (isVoted)
            ? Icon(
                Icons.check,
                color: Colors.green,
              )
            : Icon(
                Icons.close,
                color: Colors.red,
                //size: getProportionateScreenHeight(20),
              ),
      ],
    );
  }
}
