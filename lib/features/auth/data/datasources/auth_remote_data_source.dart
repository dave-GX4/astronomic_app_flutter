import 'dart:convert';
import 'dart:developer';
import 'package:app_rest/core/error/exception.dart';
import 'package:app_rest/features/auth/data/models/auth_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../../../core/network/http_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<bool> createUser(UserModel userModel);
  Future<String> verifyUser(AuthModel authModel); 
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String apiUrl = dotenv.env['API_URL'] ?? ''; 

  AuthRemoteDataSourceImpl({http.Client? client}) : client = client ?? HttpClient().client;

  @override
  Future<bool> createUser(UserModel userModel) async {
    final url = Uri.parse('$apiUrl/api/v1/auth/singin'); 
    
    _logRequest('POST', url, userModel.toJson());

    try {
      final response = await client.post(
        url,
        body: jsonEncode(userModel.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      _logResponse(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

          if (jsonResponse['status'] == true) {
            return true;
          } else {
            throw ServerException(
              message: jsonResponse['message'] ?? 'Error desconocido del servidor',
              statusCode: response.statusCode
            );
          }
        } catch (e) {
           if (e is ServerException) rethrow;
           throw DataParsingException(message: "Respuesta inválida del servidor");
        }
      } else {
        // Errores 400, 404, 500
        throw ServerException(
          message: 'Error HTTP: ${response.statusCode} ${response.reasonPhrase}',
          statusCode: response.statusCode
        );
      }
    } on http.ClientException {
      // Captura errores de conexión (sin internet, timeout, host no encontrado)
      throw NetworkException(message: "Sin conexión a internet");
    } catch (e, stackTrace) {
      // Evitamos envolver una excepción que ya es nuestra
      if (e is ServerException || e is NetworkException || e is DataParsingException) {
        rethrow;
      }
      
      print('[ERROR NO CONTROLADO]: $e');
      print(stackTrace);
      throw ServerException(message: "Error inesperado: $e");
    }
  }

  @override
  Future<String> verifyUser(AuthModel authModel) async {
    final url = Uri.parse('$apiUrl/api/v1/auth/singup');

    _logRequest('POST', url, authModel.toJson());

    try {
      final response = await client.post(
        url,
        body: jsonEncode(authModel.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      
      _logResponse(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          
          if (jsonResponse['status'] == true) {
            // Verificamos que venga el ID
            if (jsonResponse['id'] != null) {
              return jsonResponse['id'].toString();
            } else {
              throw DataParsingException(message: "El servidor no devolvió el ID de usuario");
            }
          } else {
            throw ServerException(
              message: jsonResponse['message'] ?? 'Error de autenticación',
              statusCode: response.statusCode
            );
          }
        } catch (e) {
          if (e is ServerException || e is DataParsingException) rethrow;
          throw DataParsingException(message: "Error leyendo respuesta de login");
        }
      } else {
        throw ServerException(
          message: 'Error del servidor: ${response.statusCode}',
          statusCode: response.statusCode
        );
      }
    } on http.ClientException {
      throw NetworkException(message: "No se pudo conectar con el servidor. Verifica tu internet.");
    } catch (e) {
      if (e is ServerException || e is NetworkException || e is DataParsingException) {
        rethrow;
      }
      throw ServerException(message: e.toString());
    }
  }

  void _logRequest(String method, Uri url, Map<String, dynamic> body) {
    print('------- REQUEST -------');
    print('[$method] $url');
    log('Body: ${jsonEncode(body)}');
  }

  void _logResponse(http.Response response) {
    print('------- RESPONSE -------');
    print('Status: ${response.statusCode}');
    log('Body: ${response.body}');
    print('------------------------');
  }
}