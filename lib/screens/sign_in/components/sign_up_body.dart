import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conquer_bulgaria_app/screens/loading_screen/loading_window.dart';
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
            AutoSizeText(
              sWelcomeToCB,
              textAlign: TextAlign.center,
              style: kHeadingStyle.copyWith(
                  fontSize: getProportionateScreenWidth(35), height: 1),
              maxLines: 2,
            ),
            SizedBox(height: 5),
            AutoSizeText(
              sRegisterText,
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
            SizedBox(height: 14),
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
  final _firstNameController = TextEditingController();
  final _secondNameController = TextEditingController();
  final _btnController = new RoundedLoadingButtonController();

  String get _email => _emailController.text.trim();
  String get _pass => _passwordController.text.trim();
  String get _firstName => _firstNameController.text.trim();
  String get _secondName => _secondNameController.text.trim();
  String error;

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
        SizedBox(height: getProportionateScreenHeight(20)),
        customFormField(
          myController: _firstNameController,
          label: 'Име',
          hint: 'Въведете вашето име',
          icon: Icon(
            CupertinoIcons.person,
            color: kPrimaryColor,
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        customFormField(
          myController: _secondNameController,
          label: 'Фамилия',
          hint: 'Въведете фамилия',
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
            text: 'Регистрация',
            controller: _btnController,
            onPress: () async {
              if (_email.isNotEmpty &&
                  _pass.isNotEmpty &&
                  _firstName.isNotEmpty &&
                  _secondName.isNotEmpty) {
                if (checkNames(_firstName, _secondName)) {
                  try {
                    await _auth.createUserWithEmailAndPassword(
                      email: _email,
                      password: _pass,
                    );
                    final newUser = await _auth.currentUser();
                    if (newUser != null) {
                      _firestore
                          .collection('users')
                          .document(_email.toLowerCase())
                          .setData({
                        'username':
                            '${_firstName[0].toUpperCase()}${_firstName.substring(1)}' +
                                ' ' +
                                '${_secondName[0].toUpperCase()}${_secondName.substring(1)}',
                        'picture': 'none',
                        'totalPlaces': 0,
                        'places': [],
                        'votedPlaces': []
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
                    error = 'Моля въведете валидни имена';
                  });
                  Timer(Duration(seconds: 1), () {
                    _btnController.reset();
                  });
                }
              } else {
                _btnController.error();
                setState(() {
                  error = 'Моля въведете цялата необходима информация';
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

  bool checkNames(String first, String second) {
    if (first.length < 3 || second.length < 3) return false;
    if (first.contains(RegExp(r'[^A-Za-zА-Яа-я]')) ||
        second.contains(RegExp(r'[^A-Za-zА-Яа-я]'))) {
      return false;
    } else
      return true;
  }
}
