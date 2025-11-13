import 'package:delivery_dev_seller/core/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthViewmodel extends ChangeNotifier{
  final AuthRepository _repository;

  AuthViewmodel(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;


  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _repository.login(email, password);
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        throw Exception('Email ou senha inválidos.');
      } else if (e.code == 'invalid-email') {
        throw Exception('O formato do email é inválido.');
      } else {
        throw Exception('Ocorreu um erro. Tente novamente.');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}