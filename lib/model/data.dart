import 'package:flutter/cupertino.dart';

class Data extends ChangeNotifier {
  static String snimka =
      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80';
  List<User> demoUsers = [
    User(name: 'goshoenaiqkiq', image: 'none'),
    User(name: 'pesho', image: 'none'),
    User(name: 'ivan', image: 'none'),
    User(name: 'krasi', image: 'none'),
    User(name: 'mitko', image: 'none'),
    User(name: 'kostadin', image: 'none'),
    User(name: 'goergi', image: 'none'),
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

  TravelLocation _chosenLocation;
  TravelLocation get chosenLocation => _chosenLocation;
  void setChosenLocation(TravelLocation travelLocation) {
    _chosenLocation = travelLocation;
    notifyListeners();
  }

  User currentUser = User(name: 'petkan', image: 'none', places: [1, 3]);
  List<TravelLocation> demoPlaces = [
    TravelLocation(
        range: 120.4,
        id: 1,
        town: 'гр. Банско',
        name: 'Къща музей „Никола Вапцаров“',
        imageHash: 'L6DcHu00_M%d=-%4tJNZDkyB%yn-',
        image:
            'https://upload.wikimedia.org/wikipedia/commons/4/44/%D0%9A%D1%8A%D1%89%D0%B0%D1%82%D0%B0_%D0%BD%D0%B0_%D0%9D%D0%B8%D0%BA%D0%BE%D0%BB%D0%B0_%D0%92%D0%B0%D0%BF%D1%86%D0%B0%D1%80%D0%BE%D0%B2.jpg'),
    // TravelLocation(
    //     id: 2,
    //     town: 'гр. Банско',
    //     name: 'Къща музей „Неофит Рилски“',
    //     image:
    //         'https://upload.wikimedia.org/wikipedia/commons/2/27/Museum_House_of_Neofit_Rilski.jpg'),
    // TravelLocation(
    //     range: 165.7,
    //     id: 3,
    //     town: 'гр. Банско',
    //     name: 'Велянова къща',
    //     image:
    //         'https://upload.wikimedia.org/wikipedia/commons/0/06/%D0%92%D0%B5%D0%BB%D1%8F%D0%BD%D0%BE%D0%B2%D0%B0%D1%82%D0%B0_%D0%BA%D1%8A%D1%89%D0%B0_%D0%91%D0%B0%D0%BD%D1%81%D0%BA%D0%BE.JPG'),
    // TravelLocation(
    //     id: 4,
    //     town: 'гр. Банско',
    //     name: 'Банска художествена школа',
    //     range: 150.4,
    //     image:
    //         'https://upload.wikimedia.org/wikipedia/commons/0/08/Bansko_Icon_Gallery_Icons.jpg'),
    TravelLocation(
      id: 5,
      imageHash: 'L6B|c,00Dw-600~ntAavbx%4tIIq',
      image:
          'https://bulgariatravel.org/wp-content/uploads/2016/076_003_Chudnite_mostove.jpg_7362.jpg',
      town: 'гр. Смолян',
      name: 'Чудните мостове',
      range: 150.4,
      info:
          "Чудните мостове са невероятен скален феномен в Западните Родопи. Разположени са в карстовата долина на река Еркюприя, в подножието на връх Голям Персенк, само на 5км северозападно от село Забърдо. Тези чудеса на природата са се образували от срутването на пещера преди хиляди години.\nМоже да стигнете до Чудните мостове, като следвате добре обозначените табели от село Забърдо. Макар пътят да е тесен и стръмен, може да се преминава с кола. Друг вариант е да поемете по пешеходния път от Забърдо до с. Орехово, който минава точно през мостовете. Непосредствено до тях се намира хижа \"Чудните мостове\", а многобройни екопътеки водят към хижите \"Кабата\", \"Скалните мостове\", \"Изгрев\" и \"Персенк\".\nКойто и път да изберете, ще се наслаждавате на прекрасна природа с вековни иглолистни гори, които обграждат трите мраморни чудеса. Големият мост е дълъг почти 100м, а на места достига 15м ширина. Състои се от три арки, като най-голямата достига до 45м височина.\mНа 200м по течението на реката ще видите и малкия мост. Той е дълъг около 60м, а височината му достига 50м. Неговата арка се извисява на 30м в небесата. След него идва ред и на съвсем малкия трети мост, който представлява понорна пещера (т.нар. губилище). Водите на река Еркюприя се губят в нея и се появят отново на повърхността след 3км.\nЛегендата за създаването на Чудните мостове разказва, че преди много години в село Забърдо незнайно откъде се появил змей, който започнал да опустошава стадата на местните пастири. Дълги години те страдали от набезите на злодея и един ден, най-накрая, измислили как да го надхитрят. Натоварили едно магаре с прахан (горящо вещество), запалили го и го изпратили срещу змея. Той го глътнал и в него бавно започнало да се разгаря огън. Обезумелият змей отчаяно се опитвал да избяга, но накрая се сгромолясал на земята и от удара се отворила голяма пролука. Когато костите му изгнили, на тяхно място се появили огромните сводести мостове, които днес са едни от природните чудеса на България.",
    )
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
  String imageHash;
  String image;
  String town;
  String info;
  double range;

  TravelLocation(
      {this.name,
      this.image,
      this.town,
      this.id,
      this.range,
      this.info,
      this.imageHash});
}
