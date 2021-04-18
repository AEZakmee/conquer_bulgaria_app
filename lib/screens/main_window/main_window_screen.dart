import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:conquer_bulgaria_app/model/user_profile.dart';
import 'package:conquer_bulgaria_app/screens/loading_screen/loading_window.dart';
import 'package:conquer_bulgaria_app/screens/others/nav_bar.dart';
import 'package:conquer_bulgaria_app/screens/splash/splash_screen.dart';
import 'package:conquer_bulgaria_app/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/app_bar.dart';
import 'components/body.dart';

class MainWindow extends StatefulWidget {
  static String routeName = '/main_window';

  @override
  _MainWindowState createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
  var _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.onAuthStateChanged.listen((FirebaseUser user) {
      if (user == null) {
        print('User is currently signed out!');
        Navigator.of(context).pushNamedAndRemoveUntil(
            SplashScreen.routeName, (Route<dynamic> route) => false);
      } else {
        print('User' + user.email + 'is signed in');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: () {
        return showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text(
                    'Сигурни ли сте че желаете да излезете от текущата сесия?'),
                content: new Text(
                    'Ще се наложи да се валидирате отново следващият път, препоръчително е просто да затворите приложението.'),
                actions: <Widget>[
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Text("Не, нека остана логнат"),
                  ),
                  SizedBox(height: 16),
                  new GestureDetector(
                    onTap: () {
                      _auth.signOut();
                    },
                    child: Text("Да, отпиши ме"),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: buildAppBar(context),
        body: GestureDetector(
          child: Body(),
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            //setState(() {});
            //FocusScope.of(context).requestFocus(new FocusNode());
          },
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 10,
          child: NavBar(),
        ),
      ),
    );
  }
}
