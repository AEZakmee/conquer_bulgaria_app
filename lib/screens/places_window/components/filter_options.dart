import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/filters.dart';
import 'package:conquer_bulgaria_app/screens/places_window/components/sort_by_filters.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';

class FilterOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: SizeConfig.screenHeight,
      child: Padding(
        padding: EdgeInsets.only(
          left: getProportionateScreenWidth(40),
          right: getProportionateScreenWidth(40),
          top: getProportionateScreenHeight(140),
          bottom: getProportionateScreenHeight(60),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFilters(
                  color: Colors.black,
                  string: 'Филтри',
                  fontWeight: FontWeight.bold,
                ),
                TextFilters(
                  string: "Сортирай по",
                  color: kTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: getProportionateScreenWidth(14),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextFilters extends StatelessWidget {
  const TextFilters({
    Key key,
    @required this.string,
    @required this.color,
    @required this.fontWeight,
    this.fontSize,
  }) : super(key: key);
  final String string;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getProportionateScreenWidth(12),
      ),
      child: Text(
        string,
        style: TextStyle(
          fontSize: fontSize ?? getProportionateScreenWidth(20),
          color: color,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
