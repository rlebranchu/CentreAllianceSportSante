
import 'package:centre_alliance_sport_sante/Services/Auth/AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _AUTH_KEY = 'AuthKey';

class AuthRepository {
  final Future<SharedPreferences> preference;
  final AuthService authService;

  AuthRepository(this.preference, this.authService);

  Future<bool> isUserLoggedIn() async {
    final SharedPreferences pref = await preference;
    return Future.delayed(const Duration(seconds: 2)).then((value) {
      return pref.getBool(_AUTH_KEY) ?? false;
    });
  }

  Future<bool> _updateLoginStatus(bool loggedIn) async {
    final SharedPreferences pref = await preference;
    return Future.delayed(const Duration(seconds: 2)).then((value) {
      return pref.setBool(_AUTH_KEY, loggedIn);
    });
  }

  Future<bool> logout() async {
    await authService.signOut();
    return _updateLoginStatus(false);
  }

  Future<bool> login(String email, String password) async {
    User? user = await authService.signInWithEmailAndPassword(email, password);
    bool isLogged = user != null;
    _updateLoginStatus(isLogged);
    return isLogged;
  }
}