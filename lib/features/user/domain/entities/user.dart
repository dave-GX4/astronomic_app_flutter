class User {
  final String? id;
  final String name;
  final String email;
  final String image;
  final List<String> tags;
  final String constellation;

  const User({
    this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.tags,
    required this.constellation
  });
}