import 'package:app_rest/features/astro/domain/entities/planent.dart';

class PlanetModel extends Planet{
  PlanetModel({
    required super.id, 
    required super.name, 
    required super.description, 
    required super.image, 
    required super.category, 
    required super.typePlanet, 
    required super.radius, 
    required super.gravity, 
    required super.temperature, 
    required super.atmosphere
  });

  factory PlanetModel.fromJson(Map<String, dynamic> json) {
    return PlanetModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      category: 'Planeta',
      typePlanet: json['typePlanet']?.toString() ?? '',
      radius: _parseToDouble(json['radius']),
      gravity: _parseToDouble(json['gravity']),
      temperature: _parseToDouble(json['temperature']),
      
      atmosphere: json['atmosphere']?.toString() ?? '',
    );
  }

  static double _parseToDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0;
  }
}