import 'package:app_rest/features/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getUserProfile();
  Future<void> deleteAccount();
  Future<void> logout();
}