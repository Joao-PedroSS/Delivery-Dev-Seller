class DeliveryDto {
  final String id;
  final String? idUser;

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
    required this.id,
    this.idUser,

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

      customerLat: map['customer_lat'],
      customerLon: map['customer_lon'],
      customerAddressLabel: map['customer_address_label'],
      customerAddressStreet: map['customer_address_street'],

      restaurantName: map['restaurant_name'],
      restaurantAddressLabel: map['restaurant_address_label'],
      restaurantAddressStreet: map['restaurant_address_street'],
      restaurantLat: map['restaurant_lat'],
      restaurantLon: map['restaurant_lon'],

      price: map['price'],
      status: map['status'],
      conclusionDate: map['conclusion_date'],
    );
  }
}