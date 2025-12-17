import 'dart:convert';
import 'package:app_rest/core/error/exception.dart';
import 'package:app_rest/core/network/http_client.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app_rest/features/astro/data/models/planet_model.dart';

abstract class PlanetRemoteDataSource {
  Future<List<PlanetModel>> getPlanets();
  Future<PlanetModel> getPlanetOfTheDay();
}

class PlanetRemoteDataSourceImpl implements PlanetRemoteDataSource{
  final http.Client client;
  final String apiUrl = dotenv.env['API_URL'] ?? '';

  PlanetRemoteDataSourceImpl({http.Client? client}) : client = client ?? HttpClient().client;

  @override
  Future<List<PlanetModel>> getPlanets() async {
    final url = Uri.parse('$apiUrl/api/v1/planet/all');
    
    try {
      final response = await client.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        try {
          final List<dynamic> jsonList = jsonDecode(response.body);
          return jsonList.map((json) => PlanetModel.fromJson(json)).toList();
        } catch (e) {
          // Si falla al convertir el JSON
          throw DataParsingException(message: "Error leyendo datos: $e");
        }
      } else {
        // Error del servidor (ej. 404, 500)
        throw ServerException(
          message: 'Error al obtener planetas', 
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
  Future<PlanetModel> getPlanetOfTheDay() async {
    final url = Uri.parse('$apiUrl/api/v1/planet/ofTheDay');
    try {
      final response = await client.get(url);
      if (response.statusCode == 200 || response.statusCode == 201) {
         try {
            final Map<String, dynamic> jsonMap = jsonDecode(response.body);
            return PlanetModel.fromJson(jsonMap);
         } catch (e) {
            throw DataParsingException(message: "Error leyendo destacado: $e");
         }
      } else {
        throw ServerException(
          message: 'Error al obtener destacado', 
          statusCode: response.statusCode
        );
      }
    } on http.ClientException {
      throw NetworkException();
    } catch (e) {
       if (e is ServerException || e is DataParsingException || e is NetworkException) {
        rethrow;
      }
      throw ServerException(message: e.toString());
    }
  }
}