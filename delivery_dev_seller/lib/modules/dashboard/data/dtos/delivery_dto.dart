class DeliveryDto {
  final String? id;
  final String? idUser;
  final String? driverName;
  final String? restaurantId;

  final String restaurantName;
  final double restaurantLat;
  final double restaurantLon;
  final String restaurantAddressLabel;
  final String restaurantAddressStreet;

  final String customerAddressLabel;
  final String customerAddressStreet;
  final double customerLat;
  final double customerLon;

  double? distanceKm;

  final double price; 
  String status;
  final String? conclusionDate;

  DeliveryDto({
    this.id,
    this.idUser,
    this.driverName,
    this.restaurantId,

    required this.restaurantName,
    required this.restaurantLon,
    required this.restaurantLat,
    required this.restaurantAddressLabel,
    required this.restaurantAddressStreet,

    required this.customerAddressLabel,
    required this.customerAddressStreet,
    required this.customerLat,
    required this.customerLon,
    
    this.distanceKm,

    required this.price,
    required this.status,
    this.conclusionDate
  });

  factory DeliveryDto.fromMap(Map<String, dynamic> map) {
    return DeliveryDto(
      id: map['id'],
      idUser: map['id_user'],
      restaurantId: map['restaurant_id'],

      customerLat: (map['customer_lat'] ?? 0).toDouble(),
      customerLon: (map['customer_lon'] ?? 0).toDouble(),
      customerAddressLabel: map['customer_address_label'] ?? '',
      customerAddressStreet: map['customer_address_street'] ?? '',

      restaurantName: map['restaurant_name'] ?? '',
      restaurantAddressLabel: map['restaurant_address_label'] ?? '',
      restaurantAddressStreet: map['restaurant_address_street'] ?? '',
      restaurantLat: (map['restaurant_lat'] ?? 0).toDouble(),
      restaurantLon: (map['restaurant_lon'] ?? 0).toDouble(),

      price: (map['price'] ?? 0).toDouble(),
      status: map['status'] ?? '',
      conclusionDate: map['conclusion_date'],
      distanceKm: map['distance_km'] != null ? (map['distance_km']).toDouble() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) "id": id,
      if (idUser != null) "id_user": idUser,
      if (restaurantId != null) "restaurant_id": restaurantId,

      "restaurant_name": restaurantName,
      "restaurant_lat": restaurantLat,
      "restaurant_lon": restaurantLon,
      "restaurant_address_label": restaurantAddressLabel,
      "restaurant_address_street": restaurantAddressStreet,
      "customer_address_label": customerAddressLabel,
      "customer_address_street": customerAddressStreet,
      "customer_lat": customerLat,
      "customer_lon": customerLon,

      "status": status,
      if (conclusionDate != null) "conclusion_date" : conclusionDate,

      if (distanceKm != null) "distance_km": distanceKm,
      "price": price,
    };
  }

  DeliveryDto copyWith({
    String? driverName,
    double? distanceKm,
  }) {
    return DeliveryDto(
      id: id,
      idUser: idUser,
      driverName: driverName ?? this.driverName,
      restaurantId: restaurantId,
      
      restaurantName: restaurantName,
      restaurantLat: restaurantLat,
      restaurantLon: restaurantLon,
      restaurantAddressLabel: restaurantAddressLabel,
      restaurantAddressStreet: restaurantAddressStreet,

      customerAddressLabel: customerAddressLabel,
      customerAddressStreet: customerAddressStreet,
      customerLat: customerLat,
      customerLon: customerLon,

      distanceKm: distanceKm ?? this.distanceKm,
      price: price,
      status: status,
      conclusionDate: conclusionDate,
    );
  }
}