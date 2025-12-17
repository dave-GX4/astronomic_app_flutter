import 'package:app_rest/features/user/domain/repository/user_repository.dart';

class DeleteAccountUseCase {
  final UserRepository repository;
  DeleteAccountUseCase(this.repository);

  Future<void> call() async {
    return await repository.deleteAccount();
  }
}