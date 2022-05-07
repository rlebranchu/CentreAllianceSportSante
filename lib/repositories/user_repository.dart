import 'package:centre_alliance_sport_sante/models/models.dart';
import 'package:centre_alliance_sport_sante/services/user_service.dart';

class UserRepository {
  final UserService _userService = UserService();

  User currentUser = User.empty;

  Future<User> getUserById({required String userId}) async {
    return await _userService.getUserById(userId);
  }
}
