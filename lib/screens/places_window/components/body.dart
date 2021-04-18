import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/screens/main_window/components/places_cards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import 'places_card_big.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool checkedValue = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        children: [
          SizedBox(
            width: double.infinity,
          ),
          ...List.generate(
            Provider.of<Data>(context).placesLength,
            (index) => BigPlacesCard(
              travelLocation: Provider.of<Data>(context).sortedPlaces[index],
            ),
          ),
        ],
      ),
    );
  }
}
