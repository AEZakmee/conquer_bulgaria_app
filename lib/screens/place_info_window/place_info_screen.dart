import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'components/body.dart';

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
            color: Colors.white,
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
              .contains(
                  Provider.of<Data>(context, listen: false).chosenLocation.id))
          ? FloatingActionButton.extended(
              onPressed: () {},
              label: Text(
                'Отбележи ме!',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              backgroundColor: kPrimaryColor,
              icon: Icon(
                Icons.add_location,
                color: Colors.white,
                size: 24,
              ),
            )
          : null,
      body: Body(),
    );
  }
}
