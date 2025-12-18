import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email, 
    required super.image, 
    required super.tags, 
    required super.constellation,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '', 
      image: json['image'] ?? '', 
      tags: (json['tags'] as List<dynamic>?) ?.map((e) => e.toString()).toList() ?? [],
      constellation: json['constellation'] ?? '',
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      image: user.image,
      tags: user.tags,
      constellation: user.constellation,
    );
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'name': name,
      'email': email,
      'tags': tags,
      'constellation': constellation,
    };
  }
}