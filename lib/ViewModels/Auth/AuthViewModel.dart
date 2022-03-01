import 'package:flutter/material.dart';
import '../../Repository/Auth/AuthRepository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository? authRepository;
  bool logingIn = false;
  bool logingOut = false;

  AuthViewModel(this.authRepository);

  // Basic auth function without check of input and generation of token
  // [Idea for future dev] : Check if account exist in database (Firebase)
  Future<bool> login() async {
    logingIn = true;
    // Notify Providers : logingOut starting
    notifyListeners();
    final result = await authRepository!.login();
    logingIn = false;
    // Notify Providers : logingIn ending
    notifyListeners();
    return result;
  }

  // Basic auth function without token destructor
  Future<bool> logout() async {
    logingOut = true;
    // Notify Providers : logingOut starting
    notifyListeners();
    final logoutResult = await authRepository!.logout();
    logingOut = false;
    // Notify Providers : logingOut ending
    notifyListeners();
    return logoutResult;
  }
}