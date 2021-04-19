import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/filters.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';
import 'places_card_big.dart';
import 'sort_by_filters.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: SizeConfig.screenWidth,
            color: Colors.grey.shade300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: getProportionateScreenHeight(4), left: 12),
                  child: Text(
                    'Сортирай по',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      color: kBoldTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(2),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        sortByStrings.length,
                        (index) => SortByContainer(
                          sortByType: sortByStrings.keys.toList()[index],
                          chosenSort:
                              Provider.of<Data>(context).placeFilters.sortType,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
              ],
            ),
          ),
          Wrap(
            alignment: WrapAlignment.spaceAround,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              ...List.generate(
                Provider.of<Data>(context).placesLength,
                (index) => BigPlacesCard(
                  travelLocation:
                      Provider.of<Data>(context).sortedPlaces[index],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
