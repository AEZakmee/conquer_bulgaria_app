import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:conquer_bulgaria_app/screens/place_info_window/place_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../strings.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    Key key,
  }) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  var _textFieldController = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<TravelLocation>> key = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: getProportionateScreenHeight(-30),
      child: Container(
        alignment: Alignment.center,
        width: getProportionateScreenWidth(300),
        height: getProportionateScreenHeight(60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: kBoxColor),
          boxShadow: [
            BoxShadow(
              offset: Offset(3, 3),
              blurRadius: 10,
              color: Colors.black.withOpacity(0.7),
              spreadRadius: -1,
            ),
          ],
        ),
        child: AutoCompleteTextField<TravelLocation>(
          key: key,
          controller: _textFieldController,
          suggestions: Provider.of<Data>(context).places,
          itemFilter: (TravelLocation item, query) {
            return item.name.toLowerCase().contains(query.toLowerCase()) ||
                item.town.toLowerCase().contains(query.toLowerCase());
          },
          itemSorter: (a, b) => a.name.length.compareTo(b.name.length),
          itemSubmitted: (item) {
            Provider.of<Data>(context, listen: false).setChosenLocation(item);
            Navigator.pushNamed(context, PlacesInfoWindow.routeName);
          },
          itemBuilder: (context, TravelLocation suggestion) => new Padding(
              child: new ListTile(
                  title: new Text(suggestion.name),
                  trailing: new Text(suggestion.town)),
              padding: EdgeInsets.all(8.0)),
          style: TextStyle(
            color: kBoxColor,
            fontSize: getProportionateScreenHeight(20),
          ),
          decoration: InputDecoration(
            enabledBorder: kSearchOutlineInputBorder,
            focusedBorder: kSearchOutlineInputBorder,
            border: kSearchOutlineInputBorder,
            hintText: sSearchPlace,
            hintStyle: TextStyle(
              color: kBoxColor,
              fontSize: getProportionateScreenHeight(20),
            ),
            suffixIcon: Icon(
              Icons.search,
              color: kPrimaryColor,
              size: getProportionateScreenHeight(35),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(25),
              //vertical: getProportionateScreenHeight(15),
            ),
          ),
        ),
      ),
    );
  }
}

// TextField(
//   onChanged: (v) {},
//   cursorColor: kPrimaryColor,
//   textAlign: TextAlign.left,
//   textAlignVertical: TextAlignVertical.center,
//   style: TextStyle(
//     color: kBoxColor,
//     fontSize: getProportionateScreenHeight(20),
//   ),
//   decoration: InputDecoration(
//     enabledBorder: kSearchOutlineInputBorder,
//     focusedBorder: kSearchOutlineInputBorder,
//     border: kSearchOutlineInputBorder,
//     hintText: sSearchPlace,
//     hintStyle: TextStyle(
//       color: kBoxColor,
//       fontSize: getProportionateScreenHeight(20),
//     ),
//     suffixIcon: GestureDetector(
//       onTap: () {
//         print('searched');
//       },
//       child: Icon(
//         Icons.search,
//         color: kPrimaryColor,
//         size: getProportionateScreenHeight(35),
//       ),
//     ),
//     contentPadding: EdgeInsets.symmetric(
//       horizontal: getProportionateScreenWidth(25),
//       //vertical: getProportionateScreenHeight(15),
//     ),
//   ),
// ),
