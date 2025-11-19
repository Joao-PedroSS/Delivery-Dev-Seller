class UserDto {
  final String? id;
  final String name;
  final String restaurantId;
  final String userRole;
  final bool online;
  final double lat;
  final double lon;
  final String status;

  UserDto({
    this.id,
    required this.name,
    required this.restaurantId,
    required this.userRole,
    required this.online,
    required this.lat,
    required this.lon,
    required this.status
  });

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      id: map['id'],
      status: map['status'],
      name: map['name'],
      restaurantId: map['restaurant_id'],
      userRole: map['user_role'],
      online: map['online'],
      lat: map['lat'],
      lon: map['lon']
    );
  }
}