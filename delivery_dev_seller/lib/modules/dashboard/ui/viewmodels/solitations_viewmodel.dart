import 'package:delivery_dev_seller/modules/dashboard/data/models/delivery_dto.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/models/restaurant_dto.dart';
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
      required double? customerLat, 
      required double? customerLon,
      required String? customerAddressLabel, 
      required String? customerAddressStreet
    }) async {
    try {
      createSolitationError = null;
      _isLoadingModal = true;
      notifyListeners();

      await usersRepository.fetchUser();

      String? restaurantId = usersRepository.idRestaurant;

      if (restaurantId == null) {
        throw Exception('Erro ao buscar restaurante');
      }

      final RestaurantDto? restaurant = await deliveryRepository.getRestaurant(idRestaurant: restaurantId);

      if (restaurant == null) {
        throw Exception('Erro ao buscar cidade, dados vazios');
      }

      if ([customerLat, customerLon].every((value) => value == null)) {

      }

      final solitation = DeliveryDto(
        restaurantName: restaurant.restaurantName,
        restaurantLon: restaurant.lon,
        restaurantLat: restaurant.lat,
        restaurantAddressLabel: restaurant.adressLabel,
        restaurantAddressStreet: restaurant.adressStreet,
        customerAddressLabel: customerAddressLabel!, 
        customerAddressStreet: customerAddressStreet!, 
        customerLat: customerLat!, 
        customerLon: customerLon!, 
        idUser: '',
        conclusionDate: '',
        distanceKm: 0,
        price: 10.50, 
        status: 'pending'
      );

      deliveryRepository.createSolitation(delivery: solitation);

    } catch (e) {
      print('erro ao criar solicitação: ' + e.toString());
      createSolitationError = e.toString();
    } finally {
      _isLoadingModal = false;
      notifyListeners();
    }
  }
}