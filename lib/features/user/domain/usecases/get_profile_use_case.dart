import 'package:app_rest/features/user/domain/entities/user.dart';
import 'package:app_rest/features/user/domain/repository/user_repository.dart';

class GetProfileUseCase {
  final UserRepository repository;
  GetProfileUseCase(this.repository);
  
  Future<User> call() async {
    return await repository.getUserProfile();
  }
}