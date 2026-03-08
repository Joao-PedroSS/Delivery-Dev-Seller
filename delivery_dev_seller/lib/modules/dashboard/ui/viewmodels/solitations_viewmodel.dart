import 'package:delivery_dev_seller/modules/dashboard/data/dtos/delivery_dto.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/repositories/delivery_repository.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/repositories/users_repository.dart';
import 'package:flutter/material.dart';

class SolitationsViewmodel extends ChangeNotifier {
  bool _isLoadingModal = false;
  bool get isLoadingModal => _isLoadingModal;
  String? createSolitationError;

  final UsersRepository usersRepository;
  final DeliveryRepository deliveryRepository;

  int? countDriversOnline;
  int? countRestaurantSolitations;

  SolitationsViewmodel(this.deliveryRepository, this.usersRepository);

  Stream<List<DeliveryDto>> get ordersStream =>
      deliveryRepository.getOrdersStream();

  Future<void> createSolitation({
    required double? customerLat,
    required double? customerLon,
    required String? address,
  }) async {
    try {
      createSolitationError = null;
      _isLoadingModal = true;
      notifyListeners();

      await usersRepository.fetchUser();

      final restaurantId = usersRepository.idRestaurant;
      if (restaurantId == null) {
        throw Exception('Erro ao buscar restaurante');
      }

      final restaurant = await deliveryRepository.getRestaurant(
        idRestaurant: restaurantId,
      );
      if (restaurant == null) {
        throw Exception('Erro ao buscar cidade, dados vazios');
      }

      final solitation = DeliveryDto(
        restaurantId: restaurantId,
        restaurantName: restaurant.restaurantName,
        restaurantLon: restaurant.lon,
        restaurantLat: restaurant.lat,
        restaurantAddress: restaurant.address,
        customerAddress: address!,
        customerLat: customerLat!,
        customerLon: customerLon!,
        idUser: '',
        conclusionDate: '',
        distanceKm: 0,
        price: 10.50,
        status: 'pending',
      );

      await deliveryRepository.createSolitation(delivery: solitation);
    } catch (e) {
      debugPrint('erro ao criar solicitacao: $e');
      createSolitationError = e.toString();
    } finally {
      _isLoadingModal = false;
      notifyListeners();
    }
  }
}
