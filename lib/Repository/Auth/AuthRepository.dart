
import 'package:shared_preferences/shared_preferences.dart';

const String _AUTH_KEY = 'AuthKey';

class AuthRepository {
  final Future<SharedPreferences> preference;

  AuthRepository(this.preference);

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

  Future<bool> logout() => _updateLoginStatus(false);

  Future<bool> login() => _updateLoginStatus(true);
}