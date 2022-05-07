import 'package:centre_alliance_sport_sante/models/models.dart';
import 'package:centre_alliance_sport_sante/services/session_service.dart';

class SessionRepository {
  final SessionService _sessionService = SessionService();

  Future<List<Session>> getListSessionsOfUser({required String userId}) async {
    return await _sessionService.getListSessionsOfUser(userId);
  }
}
