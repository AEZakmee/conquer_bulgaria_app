import 'package:conquer_bulgaria_app/constants.dart';
import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'components/body.dart';

class LeaderBoardWindow extends StatelessWidget {
  static String routeName = '/leaderBoard';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      appBar: buildAppBar(),
      body: Body(),
    );
  }
}
