import 'package:app_rest/features/astro/data/datasource/planet_remote_data_source.dart';
import 'package:app_rest/features/astro/domain/entities/planent.dart';
import 'package:app_rest/features/astro/domain/repositories/planets_repository.dart';

class PlanetRepositoryImpl implements PlanetsRepository {
  final PlanetRemoteDataSource remoteDataSource;

  PlanetRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Planet>> getAllPlanets() async {
    final models = await remoteDataSource.getPlanets();
    return models;
  }

  @override
  Future<Planet> getPlanetOfTheDay() async {
    final model = await remoteDataSource.getPlanetOfTheDay();
    return model;
  }
  
  @override
  Future<Planet> getByIdPlanet(String id) async {
    final model = await remoteDataSource.getByIdPlanet(id);
    return model;
  }
}