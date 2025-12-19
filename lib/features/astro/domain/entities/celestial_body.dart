abstract class CelestialBody {
  final String id;
  final String name;
  final String image;
  final String description;
  final String category;

  const CelestialBody({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.category,
  });
}