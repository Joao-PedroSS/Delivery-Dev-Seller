class RestaurantDto {
  final String? id;
  final String address;
  final String restaurantName;
  final double lat;
  final double lon;

  RestaurantDto({
    this.id,
    required this.address,
    required this.restaurantName,
    required this.lat,
    required this.lon,
  });

  factory RestaurantDto.fromMap(Map<String, dynamic> map) {
    return RestaurantDto(
      id: map['id'],
      address: map['address'] ?? '',
      restaurantName: map['name'],
      lat: map['lat'],
      lon: map['lon'],
    );
  }
}
