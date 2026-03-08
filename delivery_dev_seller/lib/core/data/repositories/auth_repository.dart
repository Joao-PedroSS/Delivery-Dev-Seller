
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {

  AuthRepository(); 

  Future<void> login(
    String email,
    String password, {
    required bool rememberMe,
  }) async {
    try {
      if (kIsWeb) {
        await FirebaseAuth.instance.setPersistence(
          rememberMe ? Persistence.LOCAL : Persistence.SESSION,
        );
      }

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException {
      rethrow;
    }
  }
}
