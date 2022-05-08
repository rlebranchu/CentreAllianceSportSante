import 'package:centre_alliance_sport_sante/models/models.dart';
import 'package:centre_alliance_sport_sante/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AuthenticationService {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final UserService _userService;

  User currentUser = User.empty;

  AuthenticationService({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _userService = UserService();

  Stream<Future<User>> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) async {
      final user = firebaseUser == null
          ? User.empty
          : await _userService.getUserById(firebaseUser.uid);
      currentUser = user;
      return user;
    });
  }

  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (_) {}
  }

  Future<void> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } catch (_) {}
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid);
  }
}
