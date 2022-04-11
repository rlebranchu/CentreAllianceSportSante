import 'package:centre_alliance_sport_sante/Models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final CollectionReference users = FirebaseFirestore.instance.collection('users').withConverter<User>(
    fromFirestore: (snapshots, _) => User.fromDocument(snapshots),
    toFirestore: (user, _) => user.toJson()
  );

  Future<User?> getUserById(String id) async {
    return (await users.doc(id).get()).data()! as User;
  }


}