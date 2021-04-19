import 'package:flutter/material.dart';

import 'components/app_bar.dart';
import 'components/body.dart';

class PlacesWindow extends StatelessWidget {
  static String routeName = '/places_window';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.grey.shade200,
      body: Body(),
    );
  }
}
