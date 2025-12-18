import 'package:app_rest/features/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getUserProfile();
  Future<bool> editProfile(User user);
  Future<void> deleteAccount();
  Future<void> logout();
}