
import 'dart:convert';

import 'package:centre_alliance_sport_sante/Models/User.dart' as App;
import 'package:centre_alliance_sport_sante/Services/AuthService.dart';
import 'package:centre_alliance_sport_sante/Services/UserService.dart';
import 'package:centre_alliance_sport_sante/Utility/Constants.dart';
import 'package:centre_alliance_sport_sante/Utility/SharedPreferencesUtility.dart';
import 'package:firebase_auth/firebase_auth.dart' as Firebase;
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final SharedPreferencesUtility preferenceUtility;
  final AuthService authService;
  final UserService userService;

  AuthRepository(this.preferenceUtility, this.authService, this.userService);

  Future<bool> isUserLoggedIn() async {
    return preferenceUtility.isUserLoggedIn();
  }

  Future<bool> _updateLoginStatus(bool loggedIn) async {
    return preferenceUtility.updateLoginStatus(loggedIn);
  }

  Future<bool> _updateUserLogged(Firebase.User firebaseUser) async {
    final App.User? user = await userService.getUserById(firebaseUser.uid);
    if(user == null) {
      return false;
    }
    else {
      return preferenceUtility.updateUserLogged(json.encode(user.toJson()));
    }
  }

  Future<bool> logout() async {
    await authService.signOut();
    preferenceUtility.updateUserLoggout();
    return _updateLoginStatus(false);
  }

  Future<bool> login(String email, String password) async {
    Firebase.User? firebaseUser = await authService.signInWithEmailAndPassword(email, password);
    if(firebaseUser ==null) {
      return _updateUserLogged(firebaseUser!);
    } else {
      return false;
    }
  }
}