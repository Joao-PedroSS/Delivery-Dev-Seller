import 'package:delivery_dev_seller/modules/dashboard/data/dtos/delivery_dto.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/repositories/delivery_repository.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/repositories/users_repository.dart';
import 'package:flutter/material.dart';

class DashboardViewmodel extends ChangeNotifier {
  final DeliveryRepository _deliveryRepository;
  final UsersRepository _usersRepository;
  
  int? countRestaurantSolitations;
  int? countDriversOnline;

  List<DeliveryDto> deliveries = [];

  DashboardViewmodel(this._deliveryRepository, this._usersRepository) {
    _deliveryRepository.getInProgressOrdersStream().listen((data) {
      deliveries = data;
      notifyListeners();
    });

    initViewmodel();
  }

  void initViewmodel() async {
    final countD = await _usersRepository.getOnlineDriversCount();

    if (countD != null) {
      countDriversOnline = countD;
    } else {
      countDriversOnline = 0;
    }

    await _usersRepository.fetchUser();

    String? restaurantId = _usersRepository.idRestaurant;

    if (restaurantId == null) {
      throw Exception('Erro ao buscar restaurante');
    }

    final countR = await _deliveryRepository.getRestaurantSolitationsCount(
      restaurantId: restaurantId
    );

    if(countR !=  null) {
      countRestaurantSolitations = countR;
    } else {
      countRestaurantSolitations = 0;
    }

    notifyListeners();
  }
}