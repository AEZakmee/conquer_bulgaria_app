import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/app_bar.dart';
import 'components/body.dart';

class MainWindow extends StatelessWidget {
  static String routeName = '/main_window';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context),
      body: Body(),
    );
  }
}
