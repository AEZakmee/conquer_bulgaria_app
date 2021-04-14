import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/screens/main_window/components/places_cards.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import 'places_card_big.dart';

class Body extends StatelessWidget {
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
              travelLocation: Provider.of<Data>(context).places[index],
            ),
          ),
        ],
      ),
    );
  }
}
