import 'package:centre_alliance_sport_sante/models/session_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SessionService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Session>> getListSessionsOfUser(String userId) async {
    final snapshot = await firestore
        .collection('sessions')
        .where('userId', isEqualTo: 'userId')
        .get();
    return snapshot.docs
        .map((doc) => Session.fromFirestore(doc.id, doc.data()))
        .toList();
  }
}
