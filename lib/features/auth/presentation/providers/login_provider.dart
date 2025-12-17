import 'package:app_rest/features/auth/domain/usecases/verifyUser_usecase.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/auth.dart';

class LoginProvider with ChangeNotifier {
  final VerifyuserUsecase _verifyUserUsecase;

  LoginProvider(this._verifyUserUsecase);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final auth = Auth(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    try {
      await _verifyUserUsecase(auth);
      
      _isLoading = false;
      notifyListeners();
      return true;

    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  void resetForm() {
    emailController.clear();
    passwordController.clear();
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}