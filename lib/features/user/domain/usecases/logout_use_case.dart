import 'package:app_rest/features/user/domain/repository/user_repository.dart';

class LogoutUseCase {
  final UserRepository repository;
  
  LogoutUseCase(this.repository);

  Future<void> call() async {
    return await repository.logout();
  }
}