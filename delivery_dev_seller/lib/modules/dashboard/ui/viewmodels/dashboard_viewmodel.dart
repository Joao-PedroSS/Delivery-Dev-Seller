import 'package:delivery_dev_seller/modules/dashboard/data/dtos/delivery_dto.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/repositories/delivery_repository.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/repositories/users_repository.dart';
import 'package:flutter/material.dart';

class DashboardViewmodel extends ChangeNotifier {
  final DeliveryRepository _deliveryRepository;
  final UsersRepository _usersRepository;
  
  int? countRestaurantSolitations;
  int? countDriversOnline;
  String? initError;
  String? ordersError;
  bool isInitializing = true;
  bool isLoadingOrders = true;

  List<DeliveryDto> deliveries = [];

  DashboardViewmodel(this._deliveryRepository, this._usersRepository) {
    _deliveryRepository.getInProgressOrdersStream().listen(
      (data) {
        deliveries = data;
        ordersError = null;
        isLoadingOrders = false;
        notifyListeners();
      },
      onError: (Object e, StackTrace s) {
        ordersError = e.toString();
        isLoadingOrders = false;
        debugPrint('[Dashboard] stream error: $e');
        debugPrintStack(stackTrace: s);
        notifyListeners();
      },
    );

    initViewmodel();
  }

  Future<void> initViewmodel() async {
    debugPrint("[Initialization]: Dashboard viewmodel");

    try {
      isInitializing = true;
      final countD = await _usersRepository.getOnlineDriversCount();
      countDriversOnline = countD ?? 0;

      await _usersRepository.fetchUser();
      final restaurantId = _usersRepository.idRestaurant;

      if (restaurantId == null) {
        throw Exception('Erro ao buscar restaurante');
      }

      final countR = await _deliveryRepository.getRestaurantSolitationsCount(
        restaurantId: restaurantId,
      );

      countRestaurantSolitations = countR ?? 0;
      initError = null;

      debugPrint("[Initialization]: Dashboard viewmodel initialized");
    } catch (e, s) {
      initError = e.toString();
      debugPrint('[Dashboard] init error: $e');
      debugPrintStack(stackTrace: s);
    } finally {
      isInitializing = false;
      notifyListeners();
    }
  }
}
