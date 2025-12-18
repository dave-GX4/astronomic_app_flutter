import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/edit_profile_use_case.dart';

class EditProfileProvider with ChangeNotifier {
  final EditProfileUseCase _editProfileUseCase;

  EditProfileProvider({required EditProfileUseCase editProfileUseCase}) 
      : _editProfileUseCase = editProfileUseCase;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String _selectedConstellation = "Orión";
  List<String> _selectedTags = [];

  User? _originalUser;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedConstellation => _selectedConstellation;
  List<String> get selectedTags => _selectedTags;

  void loadInitialData(User user) {
    _originalUser = user;
    nameController.text = user.name;
    emailController.text = user.email;
    
    _selectedConstellation = (user.constellation.isEmpty || user.constellation == 'Sin constelación favorita...') 
        ? "Orión" 
        : user.constellation;

    _selectedTags = List.from(user.tags);
    
    notifyListeners();
  }

  void setConstellation(String val) {
    _selectedConstellation = val;
    notifyListeners();
  }

  void toggleTag(String tag) {
    if (_selectedTags.contains(tag)) {
      _selectedTags.remove(tag);
    } else {
      if (_selectedTags.length < 3) {
        _selectedTags.add(tag);
      } else {
        print("Máximo 3 tags permitidos");
        return; 
      }
    }
    notifyListeners();
  }

  Future<bool> saveChanges() async {
    if (_originalUser == null) return false;

    if (_selectedTags.isEmpty) {
        _errorMessage = "Selecciona al menos 1 etiqueta";
        notifyListeners();
        return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedUser = User(
        id: _originalUser!.id,
        image: _originalUser!.image,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        constellation: _selectedConstellation,
        tags: _selectedTags,
      );

      final success = await _editProfileUseCase(updatedUser);
      return success;

    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}