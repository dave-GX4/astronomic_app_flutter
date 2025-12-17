import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.name,
    required super.email,
    required super.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      name: user.name,
      email: user.email,
      password: user.password,
    );
  }
}