import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:conquer_bulgaria_app/screens/loading_screen/loading_window.dart';
import 'package:conquer_bulgaria_app/screens/main_window/main_window_screen.dart';
import 'package:conquer_bulgaria_app/screens/splash/components/buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'forms.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              sWelcomeBack,
              style: kHeadingStyle,
              maxLines: 1,
            ),
            SizedBox(height: 5),
            Text(
              sSignInText,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 14),
            SignInForm(),
          ],
        ),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String get _email => _emailController.text.trim();
  String get _pass => _passwordController.text.trim();
  final _btnController = new RoundedLoadingButtonController();
  String error;

  _callError(String errorMessage) {
    if (mounted) {
      _btnController.error();
      setState(() {
        error = errorMessage.toString();
      });
      Timer(Duration(seconds: 1), () {
        if (mounted) {
          _btnController.reset();
        }
      });
      print(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customFormField(
          myController: _emailController,
          label: 'Емайл',
          hint: 'Въведете емайл',
          icon: Icon(
            CupertinoIcons.mail,
            color: kPrimaryColor,
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        customFormField(
          myController: _passwordController,
          label: 'Парола',
          hint: 'Въведете парола',
          icon: Icon(
            CupertinoIcons.padlock,
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
          controller: _btnController,
          text: 'Влез',
          onPress: () async {
            if (_email.isNotEmpty && _pass.isNotEmpty) {
              try {
                final newUser = await _auth.signInWithEmailAndPassword(
                    email: _email, password: _pass);
                if (newUser != null) {
                  Navigator.popAndPushNamed(context, LoadingScreen.routeName);
                  _btnController.success();
                }
              } catch (e) {
                //todo: catch all exceptions
                _callError(e);
              }
            } else {
              _callError('Моля напишете емейл/парола');
            }
          },
        ),
      ],
    );
  }
}
