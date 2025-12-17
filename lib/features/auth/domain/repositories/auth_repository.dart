import 'package:app_rest/features/auth/domain/entities/auth.dart';
import 'package:app_rest/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<bool>verifyUser(Auth user);

  Future<bool>createUser(User user);
}