import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/dtos/delivery_dto.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/dtos/restaurant_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:latlong2/latlong.dart';

class DeliveryRepository {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _ordersCollection;
  late final CollectionReference _restaurantCollection;

  DeliveryRepository() {
    _ordersCollection = _firestore.collection('DeliveriesOrders');
    _restaurantCollection = _firestore.collection('Restaurant');
  }

  Stream<List<DeliveryDto>> getInProgressOrdersStream() {
    final query = _ordersCollection;

    return query.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          
          data['id'] = doc.id; 
          
          return DeliveryDto.fromMap(data);
        }).where((delivery) => delivery.status == 'in_progress').toList();
      }
    );
  }

  Stream<List<DeliveryDto>> getOrdersStream() async* {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      yield [];
      return;
    }

    String? myRestaurantId;
    try {
      final userDoc = await _firestore.collection('Users').doc(uid).get();
      if (userDoc.exists) {
        myRestaurantId = userDoc.get('restaurant_id');
      } else {
        print("Debug Stream: Documento do usuário não encontrado no Firestore.");
      }
    } catch (e) {
      print('Debug Stream: Erro ao buscar restaurante do usuário: $e');
    }

    if (myRestaurantId == null) {
      yield [];
      return;
    }
    
    final query = _ordersCollection
        .where('restaurant_id', isEqualTo: myRestaurantId)
        .where('status', whereIn: ['pending', 'in_progress']);

    yield* query.snapshots().asyncMap((snapshot) async {
      
      List<DeliveryDto> deliveries = [];
      final Distance distance = const Distance();

      for (var doc in snapshot.docs) {
        try {
          final data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          
          var delivery = DeliveryDto.fromMap(data);

          if (delivery.idUser != null && delivery.idUser!.isNotEmpty) {
            final userDoc = await _firestore.collection('Users').doc(delivery.idUser).get();
            if (userDoc.exists) {
              final userData = userDoc.data() as Map<String, dynamic>;
              final driverName = userData['name'];
              
              final double driverLat = (userData['lat'] is num) ? (userData['lat'] as num).toDouble() : 0.0;
              final double driverLon = (userData['lon'] is num) ? (userData['lon'] as num).toDouble() : 0.0;

              double? distKm;
              if (driverLat != 0 && driverLon != 0 && delivery.customerLat != 0 && delivery.customerLon != 0) {
                 distKm = distance.as(
                  LengthUnit.Kilometer,
                  LatLng(driverLat, driverLon),
                  LatLng(delivery.customerLat, delivery.customerLon)
                );
              }

              delivery = delivery.copyWith(
                driverName: driverName,
                distanceKm: distKm
              );
            }
          }
          deliveries.add(delivery);
        } catch (e) {
          print("Erro ao processar pedido individual ${doc.id}: $e");
        }
      }
      return deliveries;
    });
  }

  void createSolitation({required DeliveryDto delivery}) {
    try {
      final query = _ordersCollection;

      query.add(delivery.toMap());

    } catch (e) {
      print('Erro ao criar nova solicitação: ' + e.toString());
      throw Exception('Falha ao criar nova solicitação: ' + e.toString());
    }
  }

  Future<RestaurantDto?> getRestaurant({required String idRestaurant}) async {
    try {
      final query = _restaurantCollection;

      final restaurantData = await query.doc(idRestaurant).get();

      if (!restaurantData.exists) {
        throw Exception('Erro: Restaurante não encontrado');
      }

      final dataMap = restaurantData.data() as Map<String, dynamic>;
      final RestaurantDto restaurant = RestaurantDto.fromMap(dataMap);

      return restaurant;
    } catch (e) {
      print('Erro ao buscar restaurante: ' + e.toString());
      throw Exception(e.toString());
    }
  }

  Future<int?> getRestaurantSolitationsCount({required String restaurantId}) async {
    try {
      final query = _ordersCollection;

      final count = await query.where('restaurant_id', isEqualTo: restaurantId).count().get();

      return count.count;
    } catch (e) {
      print('Erro ao contar pedidos do restaurante: ' + e.toString());
      throw Exception(e.toString());
    }
  }
}