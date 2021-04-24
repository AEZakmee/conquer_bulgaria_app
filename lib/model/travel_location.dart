class TravelLocation {
  int id;
  String name;
  String imageHash;
  String image;
  String town;
  String info;
  double longitude;
  double latitude;
  double range;
  double overallRating;
  double totalRating;
  int numberRating;
  TravelLocation(
      {this.name,
      this.image,
      this.town,
      this.id,
      this.range,
      this.info,
      this.latitude,
      this.longitude,
      this.overallRating,
      this.totalRating,
      this.numberRating,
      this.imageHash});

  factory TravelLocation.fromJson(Map<String, dynamic> json) {
    return TravelLocation(
      name: json['name'],
      image: json['image'],
      imageHash: json['imageHash'],
      town: json['town'],
      id: json['id'],
      info: json['info'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      overallRating: json['overallRating'].toDouble(),
      totalRating: json['totalRating'].toDouble(),
      numberRating: json['numberRating'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'imageHash': imageHash,
      'town': town,
      'id': id,
      'info': info,
      'latitude': latitude,
      'longitude': longitude,
      'totalRating': totalRating,
      'overallRating': overallRating,
      'numberRating': numberRating,
    };
  }
}
