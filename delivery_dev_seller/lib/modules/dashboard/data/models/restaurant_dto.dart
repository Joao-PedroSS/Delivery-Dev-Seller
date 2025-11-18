class RestaurantDto {
  final String? id;
  final String adressLabel;
  final String adressStreet;
  final String restaurantName;
  final double lat;
  final double lon;

  RestaurantDto({
    this.id,
    required this.adressLabel,
    required this.adressStreet,
    required this.restaurantName,
    required this.lat,
    required this.lon
  });

  factory RestaurantDto.fromMap(Map<String, dynamic> map) {
    return RestaurantDto(
      id: map['id'],
      adressLabel: map['adress_label'],
      adressStreet: map['adress_street'],
      restaurantName: map['name'],
      lat: map['lat'],
      lon: map['lon']
    );
  }
}