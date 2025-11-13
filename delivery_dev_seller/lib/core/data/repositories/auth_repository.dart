

import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {

  AuthRepository(); 

  Future<void> login(String email, String password) async {
    try {
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      throw Exception(e.code);
    }
  }

  Future<void> register(String email, String password) async {
    try {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      throw Exception(e.code);
    }
  }
}