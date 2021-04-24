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
  int loaded = 10;
  ScrollController _controller;
  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        loaded += 10;
        print(loaded);
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        loaded = 10;
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      child: Column(
        children: [
          Container(
            width: SizeConfig.screenWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: getProportionateScreenHeight(4),
                    left: 12,
                  ),
                  child: Text(
                    'Сортирай по',
                    style: TextStyle(
                      fontSize: getProportionateScreenHeight(12.5),
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
                      SizedBox(
                        width: getProportionateScreenWidth(12),
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
                loaded > Provider.of<Data>(context).placesLength
                    ? Provider.of<Data>(context).placesLength
                    : loaded,
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
