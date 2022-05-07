import 'package:equatable/equatable.dart';
import "package:centre_alliance_sport_sante/utility/datetime_extension.dart";

class Session extends Equatable {
  final String id;
  final DateTime? date;
  final String userId;

  const Session({
    required this.id,
    this.date,
    this.userId = '',
  });

  static const empty = Session(id: '');

  bool get isEmpty => this == Session.empty;
  bool get isNotEmpty => this != Session.empty;

  int get numDay => date != null ? date!.day : 0;
  String get dayString => date != null ? date!.getDayString() : '-';
  String get monthString => date != null ? date!.getMonthString() : '-';

  @override
  List<Object?> get props => [id];

  factory Session.fromFirestore(String id, Map<String, dynamic> doc) {
    return Session(
      id: id,
      date: doc['date'] as DateTime,
      userId: doc['userId'] as String,
    );
  }
}
