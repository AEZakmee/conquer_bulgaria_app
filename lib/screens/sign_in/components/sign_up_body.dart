import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conquer_bulgaria_app/screens/loading_screen/loading_window.dart';
import 'package:conquer_bulgaria_app/screens/main_window/main_window_screen.dart';
import 'package:conquer_bulgaria_app/screens/splash/components/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../strings.dart';
import '../sign_in_screen.dart';
import 'forms.dart';

class SignUpBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              sWelcomeToCB,
              textAlign: TextAlign.center,
              style: headingStyle.copyWith(
                  fontSize: getProportionateScreenWidth(25)),
            ),
            SizedBox(height: 5),
            Text(
              sRegisterText,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _btnController = new RoundedLoadingButtonController();

  String get _email => _emailController.text.trim();
  String get _pass => _passwordController.text.trim();
  String get _username => _usernameController.text.trim();
  String error;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customFormField(
          myController: _emailController,
          label: 'Email',
          hint: 'Enter Email',
          icon: Icon(
            CupertinoIcons.mail,
            color: kPrimaryColor,
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        customFormField(
          myController: _passwordController,
          label: 'Password',
          hint: 'Enter your Password',
          icon: Icon(
            CupertinoIcons.padlock,
            color: kPrimaryColor,
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        customFormField(
          myController: _usernameController,
          label: 'Username',
          hint: 'Enter your Username',
          icon: Icon(
            CupertinoIcons.person,
            color: kPrimaryColor,
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red, fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        SizedBox(height: getProportionateScreenHeight(20)),
        DefaultLoadingButton(
            text: 'Register',
            controller: _btnController,
            onPress: () async {
              if (_email.isNotEmpty &&
                  _pass.isNotEmpty &&
                  _username.isNotEmpty) {
                try {
                  await _auth.createUserWithEmailAndPassword(
                    email: _email,
                    password: _pass,
                  );
                  final newUser = await _auth.currentUser();
                  if (newUser != null) {
                    _firestore.collection('users').document(_email).setData({
                      'username': _username,
                      'picture': 'none',
                      'totalPlaces': 0,
                      'places': [-1]
                    }).whenComplete(() {
                      _btnController.success();
                      Navigator.popAndPushNamed(
                          context, LoadingScreen.routeName);
                    });
                  }
                } catch (e) {
                  //TODO: catch all exceptions
                  _btnController.error();
                  setState(() {
                    error = e.toString();
                  });
                  Timer(Duration(seconds: 1), () {
                    _btnController.reset();
                  });
                  print(e);
                }
              } else {
                _btnController.error();
                setState(() {
                  error = 'Please fill all the required information';
                });
                Timer(Duration(seconds: 1), () {
                  _btnController.reset();
                });
              }
            }),
        SizedBox(height: getProportionateScreenHeight(20)),
        GestureDetector(
          onTap: () =>
              Navigator.popAndPushNamed(context, SignInScreen.routeName),
          child: Text(sHaveAnAccount),
        ),
      ],
    );
  }
}
