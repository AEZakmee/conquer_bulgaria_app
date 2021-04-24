import 'user_profile.dart';

class ChosenUser {
  List<String> badges;
  User userData;
  int position;
  bool isCurrentUser;
  ChosenUser({this.userData, this.position, this.isCurrentUser = false}) {
    badges = _loadBadges(this.userData);
  }

  void updateUserData(User user) {
    userData = user;
  }

  var _positions = [5, 10, 20, 50, 100];
  List<String> _loadBadges(User data) {
    List<String> badges = [];
    if (position <= 3) {
      badges.add('assets/images/badges/place$position.png');
    } else if (position <= 10 && position > 3) {
      badges.add('assets/images/badges/top10.png');
    }
    for (int i = 0; i < _positions.length; i++) {
      if (data.totalPlaces >= _positions[i]) {
        badges.add('assets/images/badges/places${_positions[i]}.png');
      }
    }
    return badges;
  }
}
