import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthLocalDataSource {
  Future<void> saveUserId(String id);
  Future<void> logout();
  Future<String?> getUserId();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  late final FlutterSecureStorage storage;

  AuthLocalDataSourceImpl({required this.storage});

  @override
  Future<void> saveUserId(String id) async {
    await storage.write(key: 'user_id', value: id);
  }

  @override
  Future<void> logout() async {
    await storage.delete(key: 'user_id');
  }

  @override
  Future<String?> getUserId() async {
    return await storage.read(key: 'user_id');
  }
}