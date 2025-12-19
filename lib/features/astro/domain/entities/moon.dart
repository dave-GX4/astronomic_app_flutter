import 'package:app_rest/features/astro/domain/entities/celestial_body.dart';

class Moon extends CelestialBody {
  final String typeMoon;
  final String planetOrbit;
  final double radius;
  final double gravity;
  final double temperature;
  final String atmosphere;
  final String planetId;

  const Moon({
    required super.id, 
    required super.name, 
    required super.image, 
    required super.category, 
    required this.typeMoon, 
    required super.description, 
    required this.planetOrbit, 
    required this.radius, 
    required this.gravity, 
    required this.temperature, 
    required this.atmosphere, 
    required this.planetId,   
  });
}