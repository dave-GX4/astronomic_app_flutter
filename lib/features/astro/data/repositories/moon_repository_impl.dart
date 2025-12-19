import 'package:app_rest/features/astro/data/datasource/moon_remote_data_source.dart';
import 'package:app_rest/features/astro/domain/entities/moon.dart';
import 'package:app_rest/features/astro/domain/repositories/moons_repository.dart';

class MoonRepositoryImpl implements MoonsRepository {
  final MoonRemoteDataSource remoteDataSource;

  MoonRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Moon>> getAllMoons() async {
    final models = await remoteDataSource.getAllMoons();

    return models;
  }

  @override
  Future<List<Moon>> getAllMoonsByPlanet(String planetId) async {
    final models = await remoteDataSource.getAllMoonsByPlanet(planetId);

    return models;
  }

  @override
  Future<Moon> getByIdMoon(String id) async {
    final model = await remoteDataSource.getByIdMoon(id);

    return model;
  }
}