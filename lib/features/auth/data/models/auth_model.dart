import '../../domain/entities/auth.dart';

class AuthModel extends Auth {
  const AuthModel({
    required super.email, 
    required super.password
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory AuthModel.fromEntity(Auth auth) {
    return AuthModel(email: auth.email, password: auth.password);
  }
}