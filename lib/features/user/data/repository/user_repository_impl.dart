import 'package:app_rest/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:app_rest/features/user/data/datasource/user_remote_data_source.dart';
import 'package:app_rest/features/user/data/model/user_model.dart';
import 'package:app_rest/features/user/domain/entities/user.dart' show User;

import '../../domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  Future<String> _getUserIdOrThrow() async {
    final id = await localDataSource.getUserId();
    if (id == null) throw Exception("Usuario no autenticado");
    return id;
  }

  @override
  Future<User> getUserProfile() async {
    final id = await _getUserIdOrThrow();
    return await remoteDataSource.getUser(id);
  }

  @override
  Future<bool> editProfile(User user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      await remoteDataSource.updateUser(userModel);
      return true;
    } catch (e) {
      print("Error repository editProfile: $e");
      return false;
    }
  }

  @override
  Future<void> deleteAccount() async {
    final id = await _getUserIdOrThrow();
    await remoteDataSource.deleteUser(id);
    try {
      await localDataSource.logout();
    } catch (e) {
      print("Advertencia: No se pudo borrar ID local, pero la cuenta remota fue eliminada.");
    }
  }

  @override
  Future<void> logout() async {
    await localDataSource.logout(); 
  }
}