import 'package:app_rest/features/auth/domain/usecases/createUser_usecase.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';

class RegistreProvider with ChangeNotifier {
  final CreateuserUsecase _createUserUsecase;

  RegistreProvider(this._createUserUsecase);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> register() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final user = User(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    try {
      final success = await _createUserUsecase(user);
      
      _isLoading = false;
      notifyListeners();
      return success;

    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
  
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void resetForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}