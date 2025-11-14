import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/models/delivery_dto.dart';

class DeliveryRepository {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _ordersCollection;

  DeliveryRepository() {
    _ordersCollection = _firestore.collection('DeliveriesOrders');
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
}