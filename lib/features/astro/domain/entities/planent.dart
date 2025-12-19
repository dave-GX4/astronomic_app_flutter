import 'package:app_rest/features/astro/domain/entities/celestial_body.dart';

class Planet extends CelestialBody {
  final String typePlanet;
  final double radius;
  final double gravity;
  final double temperature;
  final String atmosphere;
  final double dayLength;
  final num planetNumber;
  final num moonCount;

  const Planet({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
    required super.category,
    required this.typePlanet,
    required this.radius,
    required this.gravity,
    required this.temperature,
    required this.atmosphere,
    required this.dayLength,
    required this.planetNumber,
    required this.moonCount,
  });
}