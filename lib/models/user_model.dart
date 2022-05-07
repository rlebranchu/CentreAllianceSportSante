import 'package:centre_alliance_sport_sante/models/profil_model.dart';
import 'package:equatable/equatable.dart';
import "package:centre_alliance_sport_sante/utility/string_extension.dart";

class User extends Equatable {
  final String id;
  final String email;
  final String firstname;
  final String lastname;
  final Profil profil;

  const User({
    required this.id,
    this.email = '',
    this.firstname = '',
    this.lastname = '',
    this.profil = Profil.empty,
  });

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [id, name, email, profil];

  factory User.fromFirestore(String id, Map<String, dynamic> doc) {
    return User(
      id: id,
      firstname: doc['firstname'] as String,
      lastname: doc['lastname'] as String,
      profil: Profil.empty,
    );
  }

  factory User.fromFirestoreWithProfil(String id, Map<String, dynamic> doc,
      String profilId, Map<String, dynamic> profil) {
    return User(
      id: id,
      firstname: doc['firstname'] as String,
      lastname: doc['lastname'] as String,
      profil: Profil.fromFirestore(profilId, profil),
    );
  }

  String get name {
    final String name = firstname + " " + lastname;
    return name.toTitleCase();
  }
}
