import 'package:delivery_dev_seller/modules/dashboard/data/models/delivery_dto.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/repositories/delivery_repository.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/repositories/users_repository.dart';
import 'package:flutter/material.dart';

class SolitationsViewmodel extends ChangeNotifier {
  bool _isLoadingModal = false;
  bool get isLoadingModal => _isLoadingModal;
  String? createSolitationError;

  final UsersRepository usersRepository;
  final DeliveryRepository deliveryRepository;

  SolitationsViewmodel({
    required this.deliveryRepository,
    required this.usersRepository
  });

  Future<void> createSolitation({
      required double customerLat, 
      required double customerLon,
      required String customerAddressLabel, 
      required String customerAddressStreet
    }) async {
    try {
      createSolitationError = null;
      _isLoadingModal = true;

      usersRepository.fetchUser();

      String? restaurantId = usersRepository.idRestaurant;

      if (restaurantId == null) {
        throw Exception('Erro ao buscar restaurante');
      }

      final deliveryRepository.getRestaurant(idRestaurant: restaurantId);

      final solitation = DeliveryDto(
        restaurantName: restaurantName, 
        restaurantLon: restaurantLon, 
        restaurantLat: restaurantLat,
        restaurantAddressLabel: restaurantAddressLabel, 
        restaurantAddressStreet: restaurantAddressStreet, 
        customerAddressLabel: customerAddressLabel, 
        customerAddressStreet: customerAddressStreet, 
        customerLat: customerLat, 
        customerLon: customerLon, 
        price: 10.50, 
        status: 'pending'
      );
    } catch (e) {
      print('erro ao criar solicitação: ' + e.toString());
      createSolitationError = e.toString();
    }
  }
}