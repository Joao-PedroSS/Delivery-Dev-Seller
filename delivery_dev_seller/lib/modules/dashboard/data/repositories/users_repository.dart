import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery_dev_seller/modules/dashboard/data/models/user_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UsersRepository {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _userCollections;

  UserDto? currentUser;
  String? get idRestaurant => currentUser?.restaurantId;

  UsersRepository() {
    _userCollections = _firestore.collection('Users');
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
}