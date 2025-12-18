import 'package:app_rest/features/user/domain/usecases/delete_account_use_case.dart';
import 'package:app_rest/features/user/domain/usecases/get_profile_use_case.dart';
import 'package:app_rest/features/user/domain/usecases/logout_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/user.dart' show User;

class ProfileProvider with ChangeNotifier {
  final GetProfileUseCase _getProfileUseCase;
  final LogoutUseCase _logoutUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;

  ProfileProvider({
    required GetProfileUseCase getProfileUseCase,
    required LogoutUseCase logoutUseCase,
    required DeleteAccountUseCase deleteAccountUseCase,
  })  : _getProfileUseCase = getProfileUseCase, _logoutUseCase = logoutUseCase, _deleteAccountUseCase = deleteAccountUseCase;

  User? _user; 
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadUserProfile() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userResult = await _getProfileUseCase();
      _user = userResult; 
      
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signOut() async {
    try {
      await _logoutUseCase();
      _user = null;
      return true; 
    } catch (e) {
      _errorMessage = "Error al cerrar sesión";
      return false;
    }
  }

  Future<bool> deleteAccount() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _deleteAccountUseCase();
      
      _isLoading = false;
      notifyListeners();
      return true; 

    } catch (e) {
      print("❌ ERROR ELIMINANDO CUENTA: $e");
      
      _errorMessage = "No se pudo eliminar: ${e.toString()}";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}