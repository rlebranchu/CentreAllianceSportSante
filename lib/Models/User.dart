import 'package:cloud_firestore/cloud_firestore.dart';
import "package:centre_alliance_sport_sante/Utility/StringExtension.dart";

class User {
  final String id;
  final String profil;
  final String firstname;
  final String lastname;

  User(
      {required this.id,
      required this.profil,
      required this.firstname,
      required this.lastname});

  factory User.fromDocument(DocumentSnapshot doc) {
    Map<String, Object?> json = doc.data()! as Map<String, Object?>;
    return User(
      id: doc.reference.id,
      firstname: json['firstname']! as String,
      lastname: json['lastname']! as String,
      profil: json['profil']! as String,
    );
  }

  factory User.fromJson(Map<String, Object?> json) {
    return User(
      id: json['firstname']! as String,
      firstname: json['firstname']! as String,
      lastname: json['lastname']! as String,
      profil: json['profil']! as String,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'profil': profil,
      'firstname': firstname,
      'lastname': lastname,
    };
  }

  String get name {
    final name = firstname + " " + lastname;
    return name.toTitleCase();
  }

}
