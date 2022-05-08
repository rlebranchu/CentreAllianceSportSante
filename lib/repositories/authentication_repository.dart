import 'package:centre_alliance_sport_sante/models/models.dart';
import 'package:centre_alliance_sport_sante/services/services.dart';

class AuthenticationRepository {
  final AuthenticationService _authenticationService = AuthenticationService();

  User get currentUser {
    return _authenticationService.currentUser;
  }

  Stream<Future<User>> get user {
    return _authenticationService.user;
  }

  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    _authenticationService.logInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> logOut() async {
    _authenticationService.logOut();
  }
}
