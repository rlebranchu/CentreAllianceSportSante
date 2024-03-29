import 'package:centre_alliance_sport_sante/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firestore;

  UserService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<User> getUserById(String id) async {
    final userDoc =
        (await _firestore.collection('users').doc(id).get()).data()!;
    final profilId = (await userDoc['profil'].get()).id;
    final profilDoc =
        (await _firestore.collection('profils').doc(profilId).get()).data()!;
    return User.fromFirestoreWithProfil(id, userDoc, profilId, profilDoc);
  }
}
