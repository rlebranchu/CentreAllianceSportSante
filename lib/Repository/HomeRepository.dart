
import 'dart:convert';

import 'package:centre_alliance_sport_sante/Models/User.dart';
import 'package:centre_alliance_sport_sante/Utility/SharedPreferencesUtility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepository {
  final SharedPreferencesUtility preferenceUtility;

  HomeRepository(this.preferenceUtility);

  Future<String> getUserName() async {
    final User? user = await preferenceUtility.getUser();
    return user == null ? user!.name : "";
  }

}