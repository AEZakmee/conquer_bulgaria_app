import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class LocationInformation extends StatelessWidget {
  const LocationInformation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              Provider.of<Data>(context).chosenLocation.name,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(25),
                color: kBoldTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(12),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Text(
              calculateRangeString(
                  Provider.of<Data>(context).chosenLocation.range),
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String calculateRangeString(double range) {
    if (range == null) return '';
    if (range > 1000) return '>1000км';
    if (range > 1) return range.toStringAsFixed(1) + 'км';
    print(range);
    if (range > 0) return (range * 100).toStringAsFixed(0) + 'м';
    return '';
  }
}

class LocationStory extends StatelessWidget {
  const LocationStory({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        (Provider.of<Data>(context).chosenLocation.info != null)
            ? Provider.of<Data>(context).chosenLocation.info
            : '',
        style: TextStyle(
          fontSize: getProportionateScreenWidth(15),
          color: Colors.black87,
        ),
      ),
    );
  }
}
