import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String username;
  String picture;
  int totalPlaces;
  List<int> places;

  User({this.username, this.places, this.picture, this.totalPlaces});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'],
        picture: json['picture'],
        totalPlaces: json['totalPlaces'],
        places: List.from(json['places']));
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'picture': picture,
      'totalPlaces': totalPlaces,
      'places': places
    };
  }

  String data() {
    return this.username + ' ' + this.picture + ' ' + places.toString();
  }
}
