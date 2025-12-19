import 'package:app_rest/features/astro/domain/entities/moon.dart';

class MoonModel extends Moon {
  MoonModel({
    required super.id, 
    required super.name, 
    required super.image, 
    required super.category, 
    required super.typeMoon, 
    required super.planetOrbit, 
    required super.description, 
    required super.radius, 
    required super.gravity, 
    required super.temperature, 
    required super.atmosphere, 
    required super.planetId
  });

  factory MoonModel.fromJson(Map<String, dynamic> json) {
    return MoonModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      category: 'Luna',
      typeMoon: json['typePlanet']?.toString() ?? '',
      planetOrbit: json['planetOrbit']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      radius: _parseToDouble(json['radius']),
      gravity: _parseToDouble(json['gravity']),
      temperature: _parseToDouble(json['temperature']),
      atmosphere: json['atmosphere']?.toString() ?? '',
      planetId: json['planetId']?.toString() ?? ''
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