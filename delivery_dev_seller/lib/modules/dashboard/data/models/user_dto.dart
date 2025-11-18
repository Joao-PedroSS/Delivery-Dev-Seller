class UserDto {
  final String? id;
  final String restaurantId;
  final String userRole;
  final bool online;
  final double lat;
  final double lon;

  UserDto({
    this.id,
    required this.restaurantId,
    required this.userRole,
    required this.online,
    required this.lat,
    required this.lon
  });

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      id: map['id'],
      restaurantId: map['restaurant_id'],
      userRole: map['user_role'],
      online: map['online'],
      lat: map['lat'],
      lon: map['lon']
    );
  }
}