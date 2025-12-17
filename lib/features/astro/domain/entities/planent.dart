class Planet {
  final String id;
  final String name;
  final String description;
  final String image;
  final String category;
  final String typePlanet;
  final double radius;
  final double gravity;
  final double temperature;
  final String atmosphere;

  const Planet({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    required this.typePlanet,
    required this.radius,
    required this.gravity,
    required this.temperature,
    required this.atmosphere
  });
}