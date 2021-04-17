import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:conquer_bulgaria_app/screens/splash/components/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';

import '../../../size_config.dart';

class VotingStar extends StatefulWidget {
  const VotingStar({
    Key key,
    @required this.travelLocation,
    this.voted = false,
  }) : super(key: key);

  final TravelLocation travelLocation;
  final bool voted;

  @override
  _VotingStarState createState() => _VotingStarState();
}

class _VotingStarState extends State<VotingStar> {
  int rating = 4;
  bool voteSent = false;
  void _openVoteMenu() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          child: Container(
            height: getProportionateScreenHeight(300),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RatingBar(
                      size: getProportionateScreenWidth(50),
                      isHalfAllowed: false,
                      filledColor: Color(0xffffd814),
                      onRatingChanged: (value) {
                        rating = value.toInt();
                        print(rating);
                      },
                      initialRating: 4,
                      maxRating: 5,
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(54),
                    vertical: getProportionateScreenHeight(32),
                  ),
                  child: DefaultButton(
                    onPress: () async {
                      if (!voteSent) {
                        voteSent = true;
                        try {
                          Firestore.instance
                              .runTransaction((transaction) async {
                            DocumentSnapshot freshLocation =
                                await transaction.get(Firestore.instance
                                    .collection('places')
                                    .document(
                                        widget.travelLocation.id.toString()));
                            await transaction.update(freshLocation.reference, {
                              'numberRating': freshLocation['numberRating'] + 1,
                              'totalRating':
                                  freshLocation['totalRating'] + rating,
                              'overallRating':
                                  (freshLocation['totalRating'] + rating) /
                                      (freshLocation['numberRating'] + 1),
                            });
                            //this is used by other apps but i don't like it, it doesn't show like i want
                            //((Overall Rating * Total Rating) + new Rating) / (Total Rating + 1)
                            //((4.11 * 478)+ 2)/479 // 479 is increment of new rating from 478
                          });

                          FirebaseUser user =
                              await FirebaseAuth.instance.currentUser();
                          await Firestore.instance
                              .collection('users')
                              .document(user.email.toLowerCase())
                              .updateData({
                            'votedPlaces': FieldValue.arrayUnion(
                                [widget.travelLocation.id])
                          });
                          print('voted');
                          Navigator.pop(context);
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    color: kPrimaryColor,
                    text: !voteSent ? 'Гласувай' : 'Благодарим за оценката',
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: (!widget.voted &&
                Provider.of<Data>(context)
                    .currentUser
                    .places
                    .contains(widget.travelLocation.id))
            ? _openVoteMenu
            : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: FittedBox(
                  child: Icon(
                    widget.voted ? Icons.tag_faces : Icons.star_border,
                    color: Color(0xffffd814),
                    size: getProportionateScreenWidth(40),
                  ),
                ),
              ),
              widget.voted
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
                              .contains(widget.travelLocation.id))
                          ? 'Гласувай'
                          : 'Посети, за да гласуваш',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Provider.of<Data>(context)
                                .currentUser
                                .places
                                .contains(widget.travelLocation.id)
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
