import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? user;
  bool isLoading = true;

  AuthProvider() {
    _init();
  }

  void _init() {
    user = _authService.currentUser;
    isLoading = false;
    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    String? result = await _authService.login(email, password);
    user = _authService.currentUser;
    notifyListeners();
    return result;
  }

  Future<String?> register(String email, String password, String name) async {
    String? result = await _authService.register(email, password, name);
    notifyListeners();
    return result;
  }

  Future<void> logout() async {
    await _authService.logout();
    user = null;
    notifyListeners();
  }
}