import 'dart:convert';
import 'package:app_rest/core/network/http_client.dart';
import 'package:app_rest/features/user/data/model/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<UserModel> getUser(String id);
  Future<void> deleteUser(String id);
  Future<void> updateUser(UserModel userModel);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  final String apiUrl = dotenv.env['API_URL'] ?? '';

  UserRemoteDataSourceImpl({http.Client? client}) : client = client ?? HttpClient().client;

  @override
  Future<UserModel> getUser(String id) async {
    print("🔍 Buscando usuario con ID: '$id'");
    final url = Uri.parse('$apiUrl/api/v1/user/get/$id'); 
    print("🌐 URL Generada: $url");

    try {
      final response = await client.get(url);
      
      print("📡 Respuesta Código: ${response.statusCode}");
      print("📦 Respuesta Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return UserModel.fromJson(data);
      } else {
        throw Exception('Error API: ${response.statusCode}');
      }
    } catch (e) {
      print("❌ Error en petición: $e");
      rethrow;
    }
  }

  @override
  Future<void> updateUser(UserModel userModel) async {
    final url = Uri.parse('$apiUrl/api/v1/user/update/${userModel.id}'); 
    
    print("📤 Enviando actualización a: $url");
    print("📦 Body: ${jsonEncode(userModel.toUpdateJson())}");

    try {
      final response = await client.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(userModel.toUpdateJson()), 
      );

      print("📡 Respuesta Update: ${response.statusCode}");

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Error al actualizar datos: ${response.body}');
      }
    } catch (e) {
      print("❌ Error en updateUser: $e");
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    final url = Uri.parse('$apiUrl/api/v1/user/delete/$id');
    
    final response = await client.delete(url);

    if (response.statusCode != 200 && response.statusCode != 204) {
       throw Exception('Error al eliminar cuenta');
    }
  }
}