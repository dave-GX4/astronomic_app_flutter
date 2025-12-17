
import 'package:app_rest/features/astro/domain/usecases/get_planet_of_day_use_case.dart';
import 'package:app_rest/features/astro/domain/entities/planent.dart';
import 'package:app_rest/features/astro/domain/usecases/get_all_planets_use_case.dart';
import 'package:flutter/foundation.dart';

class HomeProvider with ChangeNotifier {
  final GetAllPlanetsUseCase _getAllPlanetsUseCase;
  final GetPlanetOfDayUseCase _getPlanetOfDayUseCase;

  HomeProvider({
    required GetAllPlanetsUseCase getAllPlanetsUseCase,
    required GetPlanetOfDayUseCase getPlanetOfDayUseCase,
  })  : _getAllPlanetsUseCase = getAllPlanetsUseCase,_getPlanetOfDayUseCase = getPlanetOfDayUseCase;
  
  List<Planet> _allPlanets = [];
  Planet? _featuredPlanet;
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedCategory = 'Todos';
  String _searchQuery = '';

  List<Planet> get filteredPlanets {
    List<Planet> list = _allPlanets;

    if (_selectedCategory != 'Todos') {
      list = list.where((planet) => 
        planet.category.toLowerCase() == _selectedCategory.toLowerCase()
      ).toList();
    }

    if (_searchQuery.isNotEmpty) {
      list = list.where((planet) => 
        planet.name.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }

    return list;
  }
  Planet? get featuredPlanet => _featuredPlanet;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadHomeData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _getAllPlanetsUseCase(),
        _getPlanetOfDayUseCase(),
      ]);

      _allPlanets = results[0] as List<Planet>;
      _featuredPlanet = results[1] as Planet;

    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void searchPlanets(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}