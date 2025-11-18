import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/models/delivery_dto.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/models/restaurant_dto.dart';

class DeliveryRepository {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _ordersCollection;
  late final CollectionReference _restaurantCollection;

  DeliveryRepository() {
    _ordersCollection = _firestore.collection('DeliveriesOrders');
    _restaurantCollection = _firestore.collection('Restaurant');
  }

  Stream<List<DeliveryDto>> getOrdersStream() {
    final query = _ordersCollection;

    return query.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          
          data['id'] = doc.id; 
          
          return DeliveryDto.fromMap(data);
        }).toList();
      }
    );
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
}