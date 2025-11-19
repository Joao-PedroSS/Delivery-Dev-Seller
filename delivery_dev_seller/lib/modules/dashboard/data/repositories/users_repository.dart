import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/dtos/user_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsersRepository {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _userCollections;

  UserDto? currentUser;
  String? get idRestaurant => currentUser?.restaurantId;

  UsersRepository() {
    _userCollections = _firestore.collection('Users');
  }

  Future<List<UserDto>> fetchDrivers() async {
    try {
      final query = await _userCollections.where('user_role', isEqualTo: 'driver').get();

      final drivers = query.docs.map((doc) {
        return UserDto.fromMap(doc.data()! as Map<String, dynamic>);
      }).toList();

      return drivers;
    } catch (e) {
      print('Erro ao buscar entregadores: $e');  
      return [];
    }
  }

  Future<UserDto> fetchUser() async {
    try {
      currentUser = null;

      final query = _userCollections;
      final uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid == null) {
        throw Exception('Erro: usuario não autentificado');
      }

      final userData = await query.doc(uid).get();

      if (!userData.exists) {
        throw Exception('Erro: usuario não encontrado');
      }

      final dataMap = userData.data() as Map<String, dynamic>;

      final UserDto user = UserDto.fromMap(dataMap);

      currentUser = user;

      return user;
    } catch (e) {
      print('Erro ao procuarar usuario: ' + e.toString());
      throw Exception(e.toString());
    } 
  }

  Future<int?> getOnlineDriversCount() async {
    try {
      final query = _userCollections;

      final count = await query.where('online', isEqualTo: true).where('user_role', isEqualTo: 'driver').count().get();

      return count.count;
    } catch (e) {
      print('Erro ao contar usuarios logados: $e');
    }
  }
}