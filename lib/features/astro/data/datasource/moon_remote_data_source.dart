import 'dart:convert';

import 'package:app_rest/core/error/exception.dart';
import 'package:app_rest/core/network/http_client.dart';
import 'package:app_rest/features/astro/data/models/moon_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

abstract class MoonRemoteDataSource {
  Future<List<MoonModel>> getAllMoons();
  Future<List<MoonModel>> getAllMoonsByPlanet(String planetId);
  Future<MoonModel> getByIdMoon(String id);
}

class MoonRemoteDataSourceImpl implements MoonRemoteDataSource{
  final http.Client client;
  final String apiUrl = dotenv.env['API_URL'] ?? '';

  MoonRemoteDataSourceImpl({http.Client? client}) : client = client ?? HttpClient().client;

  @override
  Future<List<MoonModel>> getAllMoons() async {
    final url = Uri.parse('$apiUrl/api/v1/moon/getAll');
    
    try {
      final response = await client.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        try {
          final List<dynamic> jsonList = jsonDecode(response.body);
          
          return jsonList.map((json) => MoonModel.fromJson(json)).toList();
        } catch (e) {
          // Si falla al convertir el JSON
          throw DataParsingException(message: "Error leyendo datos: $e");
        }
      } else {
        // Error del servidor (ej. 404, 500)
        throw ServerException(
          message: 'Error al obtener las lunas', 
          statusCode: response.statusCode
        );
      }
    } on http.ClientException {
      throw NetworkException(message: "Sin conexión a internet");
    } catch (e) {
      if (e is ServerException || e is DataParsingException || e is NetworkException) {
        rethrow;
      }
      throw ServerException(message: "Error inesperado: $e");
    }
  }

  @override
  Future<List<MoonModel>> getAllMoonsByPlanet(String planetId) async {
    final url = Uri.parse('$apiUrl/api/v1/moon/getAllByPlanetId/$planetId');

    try {
      final response = await client.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final dynamic responseBody = jsonDecode(response.body);

        // CASO A: Hay lunas (La API devuelve una Lista)
        if (responseBody is List) {
          try {
            return responseBody.map((json) => MoonModel.fromJson(json)).toList();
          } catch (e) {
            throw DataParsingException(message: "Error procesando datos de lunas");
          }
        } 
        
        // CASO B: No hay lunas (La API devuelve un Objeto con status: false)
        else if (responseBody is Map<String, dynamic>) {
           // Aquí está la clave: Si el status es false, NO es un error, 
           // es simplemente una lista vacía.
           if (responseBody['status'] == false) {
             return []; // <--- Retornamos lista vacía
           }
        }
        
        // Si llega algo raro que no esperamos
        throw DataParsingException(message: "Respuesta inesperada del servidor");

      } else {
        // Manejo de errores de servidor (404, 500, etc)
        throw ServerException(
          message: 'Error del servidor: ${response.statusCode}', 
          statusCode: response.statusCode
        );
      }
    } on http.ClientException {
      throw NetworkException(message: "Sin conexión a internet");
    } catch (e) {
      if (e is ServerException || e is DataParsingException || e is NetworkException) {
        rethrow;
      }
      throw ServerException(message: "Error inesperado: $e");
    }
  }

  @override
  Future<MoonModel> getByIdMoon(String id) async {
    final url = Uri.parse('$apiUrl/api/v1/moon/getOne/$id');

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        return MoonModel.fromJson(json);
      } else {
        throw Exception('Error al cargar la luna: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}