import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/user_profile.dart';
import 'package:conquer_bulgaria_app/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'components/body.dart';
import 'components/floating_button.dart';

class PlacesInfoWindow extends StatelessWidget {
  static String routeName = '/places_info';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: getProportionateScreenHeight(50),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: (!Provider.of<Data>(context)
                  .currentUser
                  .places
                  .contains(Provider.of<Data>(context).chosenLocation.id) &&
              Provider.of<Data>(context).chosenLocation.range != null)
          ? VisitPlaceButton(
              userIsInPlace:
                  Provider.of<Data>(context).chosenLocation.range < 0.1 ?? 1000)
          : null,
      body: Body(),
    );
  }
}
