import 'package:app_rest/features/user/domain/entities/user.dart' show User;
import 'package:app_rest/features/user/domain/repository/user_repository.dart';

class EditProfileUseCase {
  final UserRepository repository;

  EditProfileUseCase(this.repository);

  Future<bool>call(User user) async{
    return await repository.editProfile(user);
  }
}