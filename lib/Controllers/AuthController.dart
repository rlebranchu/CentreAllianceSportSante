import 'package:centre_alliance_sport_sante/Repository/AuthRepository.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository? authRepository;
  bool logingIn = false;
  bool logingOut = false;

  AuthController(this.authRepository);

  // Basic auth function without check of input and generation of token
  // [Idea for future dev] : Check if account exist in database (Firebase)
  Future<bool> login(String email, String password) async {
    // Notify Providers : logingOut starting
    notifyListeners();
    final result = await authRepository!.login(email, password);
    logingIn = result;
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