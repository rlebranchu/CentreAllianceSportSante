import 'dart:convert';

import 'package:centre_alliance_sport_sante/Models/User.dart';
import 'package:centre_alliance_sport_sante/Utility/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

const userKey = 'user';

class SharedPreferencesUtility {
  final Future<SharedPreferences> preferences;

  SharedPreferencesUtility({required this.preferences});

  Future<User?> getUser () async {
    final pref = await preferences;
    if(pref.containsKey(USERKEY)){
      return User.fromJson(json.decode(pref.getString(USERKEY)!));
    } else {
      return null;
    }
  }

  Future<bool> updateLoginStatus(bool loggedIn) async {
    final SharedPreferences pref = await preferences;
    return pref.setBool(AUTHKEY, loggedIn);
  }

  Future<bool> updateUserLogged(String userData) async {
    final SharedPreferences pref = await preferences;
    return pref.setString(USERKEY, userData);
  }

  Future<bool> updateUserLoggout() async {
    final SharedPreferences pref = await preferences;
    return pref.remove('user');
  }

  Future<bool> isUserLoggedIn() async {
    final SharedPreferences pref = await preferences;
    return pref.getBool(AUTHKEY) ?? false;
  }
}