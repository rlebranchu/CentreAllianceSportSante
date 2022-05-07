import 'package:equatable/equatable.dart';

class Profil extends Equatable {
  final String id;
  final String name;
  final bool adminRole;

  const Profil({
    required this.id,
    this.name = '',
    this.adminRole = false,
  });

  static const empty = Profil(id: '');

  bool get isEmpty => this == Profil.empty;
  bool get isNotEmpty => this != Profil.empty;

  @override
  List<Object?> get props => [id];

  factory Profil.fromFirestore(String id, Map<String, dynamic> doc) {
    return Profil(
      id: id,
      name: doc['name'] as String,
      adminRole: doc['adminRole'] as bool,
    );
  }
}
