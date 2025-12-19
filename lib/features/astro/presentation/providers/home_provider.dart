import 'package:app_rest/features/astro/domain/entities/celestial_body.dart';
import 'package:app_rest/features/astro/domain/entities/moon.dart';
import 'package:app_rest/features/astro/domain/usecases/get_all_moons_use_case.dart';
import 'package:app_rest/features/astro/domain/usecases/get_planet_of_day_use_case.dart';
import 'package:app_rest/features/astro/domain/entities/planent.dart';
import 'package:app_rest/features/astro/domain/usecases/get_all_planets_use_case.dart';
import 'package:flutter/foundation.dart';

class HomeProvider with ChangeNotifier {
  final GetAllPlanetsUseCase _getAllPlanetsUseCase;
  final GetPlanetOfDayUseCase _getPlanetOfDayUseCase;
  final GetAllMoonsUseCase _getAllMoonsUseCase; 
  // final GetAllBlackHolesUseCase _getAllBlackHolesUseCase;

  HomeProvider({
    required GetAllPlanetsUseCase getAllPlanetsUseCase,
    required GetPlanetOfDayUseCase getPlanetOfDayUseCase,
    required GetAllMoonsUseCase getAllMoonsUseCase,
    // required GetAllBlackHolesUseCase getAllBlackHolesUseCase,
  })  : _getAllPlanetsUseCase = getAllPlanetsUseCase,
        _getPlanetOfDayUseCase = getPlanetOfDayUseCase,
        _getAllMoonsUseCase = getAllMoonsUseCase;
        // _getAllBlackHolesUseCase = getAllBlackHolesUseCase;
  
  List<CelestialBody> _allCelestialBodies = [];
  Planet? _featuredPlanet;
  
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedCategory = 'Todos';
  String _searchQuery = '';

  List<CelestialBody> get filteredItems {
    List<CelestialBody> list = [];

    if (_selectedCategory == 'Todos') {
      list = List.from(_allCelestialBodies);
    } else {
      list = _allCelestialBodies.where((item) => 
        item.category.toLowerCase() == _selectedCategory.toLowerCase()
      ).toList();
    }

    if (_searchQuery.isNotEmpty) {
      list = list.where((item) => 
        item.name.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }

    return list;
  }

  Planet? get featuredPlanet => _featuredPlanet;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get selectedCategory => _selectedCategory;

  Future<void> loadHomeData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        _getAllPlanetsUseCase(),
        _getAllMoonsUseCase(),
        _getPlanetOfDayUseCase(),
        // _getAllBlackHolesUseCase()
      ]);

      final planets = results[0] as List<Planet>;
      final moons = results[1] as List<Moon>;
      // final blackHoles = results[3] as List<BlackHole>;

      // UNIFICAR LISTAS
      _allCelestialBodies = [
        ...planets,
        ...moons,
        // ...blackHoles
      ];

      _allCelestialBodies.shuffle();

      _featuredPlanet = results[2] as Planet;

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