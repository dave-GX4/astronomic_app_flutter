import '../entities/planent.dart';

abstract class PlanetsRepository {
  Future<List<Planet>> getAllPlanets();
  
  Future<Planet> getPlanetOfTheDay();
}