import 'package:app_rest/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:app_rest/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app_rest/features/auth/data/models/auth_model.dart';

import '../../domain/entities/auth.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource
  });

  @override
  Future<bool> createUser(User user) async {
    final userModel = UserModel.fromEntity(user);
    return await remoteDataSource.createUser(userModel);
  }

  @override
  Future<bool> verifyUser(Auth auth) async {
    try {
      // Convertir la entidad a modelo
      final authModel = AuthModel.fromEntity(auth);
      // Llamar a API y obtener id
      final userId = await remoteDataSource.verifyUser(authModel);
      // Guardar id en almacenamiento seguro
      await localDataSource.saveUserId(userId);

      return true;
    } catch (e) {
      rethrow;
    }
  }
}