import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conquer_bulgaria_app/model/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class VisitPlaceButton extends StatefulWidget {
  const VisitPlaceButton({
    Key key,
    this.userIsInPlace,
  }) : super(key: key);
  final bool userIsInPlace;

  @override
  _VisitPlaceButtonState createState() => _VisitPlaceButtonState();
}

class _VisitPlaceButtonState extends State<VisitPlaceButton> {
  bool isLoading = false;

  void _updateUser() async {
    try {
      setState(() {
        isLoading = true;
      });
      print('pressed');
      if (widget.userIsInPlace) {
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        // User currentUser =
        //     Provider.of<Data>(context, listen: false).currentUser;
        // await Firestore.instance
        //     .collection('users')
        //     .document(user.email.toLowerCase())
        //     .updateData({
        //   'totalPlaces': currentUser.totalPlaces + 1,
        //   'places': FieldValue.arrayUnion(
        //       [Provider.of<Data>(context, listen: false).chosenLocation.id])
        // });
        //in the documentation they say the transaction way is better, but dk
        Firestore.instance.runTransaction((transaction) async {
          DocumentSnapshot freshUser = await transaction.get(Firestore.instance
              .collection('users')
              .document(user.email.toLowerCase()));
          await transaction.update(freshUser.reference, {
            'totalPlaces': freshUser['totalPlaces'] + 1,
            'places': FieldValue.arrayUnion(
                [Provider.of<Data>(context, listen: false).chosenLocation.id])
          });
        });
        _showSnackBar(
            message: 'Постихте обекта успешно!', context: context, duration: 3);
      } else {
        print('not close enough');
        _showSnackBar(
            message: 'Не сте достатъчно близо до обекта!', context: context);
      }
    } catch (e) {
      print(e);
      _showSnackBar(message: 'Нещо се обърка', context: context);
    }
    await Future.delayed(Duration(seconds: 10));
    if (this.mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: isLoading ? null : _updateUser,
      label: Text(
        'Отбележи ме!',
        style: TextStyle(
            color: widget.userIsInPlace ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
      backgroundColor: widget.userIsInPlace ? kPrimaryColor : Colors.grey,
      icon: Icon(
        Icons.add_location,
        color: widget.userIsInPlace ? Colors.white : Colors.black,
        size: 24,
      ),
    );
  }

  _showSnackBar(
      {int duration = 1,
      @required String message,
      @required BuildContext context}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: duration),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
