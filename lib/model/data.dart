import 'package:flutter/cupertino.dart';

class Data extends ChangeNotifier {
  static String snimka =
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80';
  List<User> demoUsers = [
    User(name: 'goshoenaiqkiq', image: snimka),
    User(name: 'pesho', image: 'none'),
    User(name: 'ivan', image: snimka),
    User(name: 'krasi', image: 'none'),
    User(name: 'mitko', image: snimka),
    User(name: 'kostadin', image: 'none'),
    User(name: 'goergi', image: snimka),
  ];
  void changeCurrentUser(User user) {
    currentUser = user;
    notifyListeners();
  }

  int get placesLength => demoPlaces.length;
  int get topUsersLength => demoUsers.length;
  void userVisitedPlace(int id) {
    currentUser.places.add(id);
    notifyListeners();
  }

  User currentUser = User(name: 'petkan', image: 'none', places: [1, 3]);
  List<TravelLocation> demoPlaces = [
    TravelLocation(
        id: 1,
        town: 'гр. Банско',
        name: 'Къща музей „Никола Вапцаров“',
        image:
            'https://upload.wikimedia.org/wikipedia/commons/4/44/%D0%9A%D1%8A%D1%89%D0%B0%D1%82%D0%B0_%D0%BD%D0%B0_%D0%9D%D0%B8%D0%BA%D0%BE%D0%BB%D0%B0_%D0%92%D0%B0%D0%BF%D1%86%D0%B0%D1%80%D0%BE%D0%B2.jpg'),
    TravelLocation(
        id: 2,
        town: 'гр. Банско',
        name: 'Къща музей „Неофит Рилски“',
        image:
            'https://upload.wikimedia.org/wikipedia/commons/2/27/Museum_House_of_Neofit_Rilski.jpg'),
    TravelLocation(
        id: 3,
        town: 'гр. Банско',
        name: 'Велянова къща',
        image:
            'https://upload.wikimedia.org/wikipedia/commons/0/06/%D0%92%D0%B5%D0%BB%D1%8F%D0%BD%D0%BE%D0%B2%D0%B0%D1%82%D0%B0_%D0%BA%D1%8A%D1%89%D0%B0_%D0%91%D0%B0%D0%BD%D1%81%D0%BA%D0%BE.JPG'),
    TravelLocation(
        id: 4,
        town: 'гр. Банско',
        name: 'Банска художествена школа',
        image:
            'https://upload.wikimedia.org/wikipedia/commons/0/08/Bansko_Icon_Gallery_Icons.jpg'),
  ];
}

class User {
  String name;
  String image;
  List<int> places;
  User({this.name, this.image, this.places});
  String data() {
    return this.name + ' ' + this.image + ' ' + places.toString();
  }
}

class TravelLocation {
  int id;
  String name;
  String image;
  String town;

  TravelLocation({this.name, this.image, this.town, this.id});
}
