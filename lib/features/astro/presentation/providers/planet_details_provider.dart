import 'package:app_rest/features/astro/domain/entities/moon.dart';
import 'package:app_rest/features/astro/domain/entities/planent.dart';
import 'package:app_rest/features/astro/domain/usecases/get_all_moons_by_planet_use_case.dart';
import 'package:app_rest/features/astro/domain/usecases/get_by_id_planet_use_case.dart';
import 'package:flutter/material.dart';

class AstroItemProvider with ChangeNotifier {
  final GetByIdPlanetUseCase _getByIdPlanetUseCase;
  final GetAllMoonsByPlanetUseCase _getAllMoonsByPlanetUseCase;

  AstroItemProvider({
    required GetByIdPlanetUseCase getByIdPlanetUseCase,
    required GetAllMoonsByPlanetUseCase getAllMoonsByPlanetUseCase
  }) : _getByIdPlanetUseCase = getByIdPlanetUseCase,  _getAllMoonsByPlanetUseCase = getAllMoonsByPlanetUseCase ;

  Planet? _planet;
  List<Moon> _moons = []; 
  bool _isLoading = true;
  String? _errorMessage;

  Planet? get planet => _planet;
  List<Moon> get moons => _moons; 
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadPlanetDetails(String id) async {
    _isLoading = true;
    _errorMessage = null;
    _planet = null;
    _moons = [];
    notifyListeners();

    try {
      final results = await Future.wait([
        _getByIdPlanetUseCase(id),
        _getAllMoonsByPlanetUseCase(id),
      ]);

      _planet = results[0] as Planet;
      _moons = results[1] as List<Moon>;

    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}