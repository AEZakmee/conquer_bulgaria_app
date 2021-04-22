import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:conquer_bulgaria_app/screens/others/nav_bar.dart';
import 'package:conquer_bulgaria_app/screens/splash/splash_screen.dart';
import 'package:conquer_bulgaria_app/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';
import 'components/drawer.dart';

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
        Provider.of<Data>(context, listen: false).loadUserEmail(user.email);
        print('User ' + user.email + ' just signed in');
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
                title:
                    new Text('Внимание! Напът сте да напуснете приложението!'),
                content: Text('Сигурни ли сте?'),
                actions: <Widget>[
                  new GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: Text("Не"),
                  ),
                  SizedBox(height: 16),
                  new GestureDetector(
                    onTap: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                    child: Text("Да"),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                size: getProportionateScreenHeight(40),
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: CustomDrawer(userMail: Provider.of<Data>(context).userMail),
        body: GestureDetector(
          child: Body(),
          onTap: () {
            final FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
              FocusManager.instance.primaryFocus.unfocus();
            }
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
