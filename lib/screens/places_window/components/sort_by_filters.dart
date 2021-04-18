import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/filters.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';

class SortByContainer extends StatelessWidget {
  const SortByContainer({
    Key key,
    @required this.sortByType,
    @required this.chosenSort,
  }) : super(key: key);
  final sortBy sortByType;
  final sortBy chosenSort;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(8)),
      child: GestureDetector(
        onTap: () {
          Provider.of<Data>(context, listen: false)
              .toggleFilterSortBy(sortByType);
        },
        child: Container(
          decoration: BoxDecoration(
            color: chosenSort == sortByType ? Colors.redAccent : Colors.grey,
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(8),
              horizontal: getProportionateScreenWidth(16),
            ),
            child: Text(
              sortByStrings[sortByType],
              style: TextStyle(
                color: chosenSort == sortByType ? Colors.black : Colors.black87,
                fontSize: getProportionateScreenWidth(14),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
