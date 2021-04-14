import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conquer_bulgaria_app/constants.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/model/travel_location.dart';
import 'package:conquer_bulgaria_app/model/user_profile.dart';
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
  final _db = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedUser;
  //todo : move it to firestoreService
  void initFirebaseListeners() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedUser = user;
        _db
            .collection('users')
            .document(loggedUser.email)
            .snapshots()
            .listen((snapshot) {
          print('listening for current User');
          User loggedUserData = User.fromJson(snapshot.data);
          Provider.of<Data>(context, listen: false)
              .changeCurrentUser(loggedUserData);
        });
        _db
            .collection('users')
            .orderBy('totalPlaces')
            .limit(10)
            .snapshots()
            .listen((querySnapshot) {
          print('listening for top users');
          Provider.of<Data>(context, listen: false).changeTopUsers(querySnapshot
              .documents
              .map((element) => User.fromJson(element.data))
              .toList());
        });

        _db.collection('places').snapshots().listen((querySnapshot) {
          print('listening for places');
          Provider.of<Data>(context, listen: false).loadPlaces(querySnapshot
              .documents
              .map((element) => TravelLocation.fromJson(element.data))
              .toList());
        });
        //print(loggedUser.email);
      } else {
        _auth.signOut();
        Navigator.pushNamed(context, SplashScreen.routeName);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    initFirebaseListeners();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        child: NavBar(),
      ),
    );
  }
}
