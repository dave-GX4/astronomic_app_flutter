import 'package:app_rest/features/auth/domain/entities/user.dart';
import 'package:app_rest/features/auth/domain/repositories/auth_repository.dart';

class CreateuserUsecase {
  final AuthRepository repository;

  CreateuserUsecase(this.repository);

  Future<bool>call(User user) async{
    return await repository.createUser(user);
  }
}