import 'package:delivery_dev_seller/modules/dashboard/data/models/delivery_dto.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/repositories/delivery_repository.dart';
import 'package:flutter/material.dart';

class DashboardViewmodel extends ChangeNotifier {
  final DeliveryRepository _deliveryRepository;
  
  List<DeliveryDto> deliveries = [];

  DashboardViewmodel(this._deliveryRepository) {
    _deliveryRepository.getOrdersStream().listen((data) {
      deliveries = data;
      notifyListeners();
    });
  }


}