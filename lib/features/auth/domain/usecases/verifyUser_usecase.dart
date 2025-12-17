import 'package:app_rest/features/auth/domain/entities/auth.dart';
import 'package:app_rest/features/auth/domain/repositories/auth_repository.dart';

class VerifyuserUsecase {
  final AuthRepository repository;

  VerifyuserUsecase(this.repository);

  Future<bool>call(Auth auth) async{
    return await repository.verifyUser(auth);
  }
}