import 'package:delivery_dev_seller/modules/dashboard/data/dtos/driver_dto.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/dtos/user_dto.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/repositories/users_repository.dart';
import 'package:flutter/material.dart';

class DriversViewmodel extends ChangeNotifier {
  final UsersRepository usersRepository;
  
  bool isLoadingDrivers = false;
  List<DriverStatusDto>? drivers;

  DriversViewmodel({required this.usersRepository});

  void fetchDrivers() async{
    try {
      isLoadingDrivers = true;

      final driversData = await usersRepository.fetchDrivers();
    
      if (driversData.isEmpty) {
        return;
      }

      drivers = driversData.map((o) {
        return DriverStatusDto(
          name: o.name,
          status: o.status,
          location: o.lat.toString() 
          );
      }).toList();        

      notifyListeners();
    } catch (e) {
      print('Erro no viewmodel ao buscar motoristas: $e');
    } finally {
      isLoadingDrivers = false;
    }
  }
}