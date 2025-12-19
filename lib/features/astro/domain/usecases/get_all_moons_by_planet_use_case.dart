import 'package:app_rest/features/astro/domain/entities/moon.dart';
import 'package:app_rest/features/astro/domain/repositories/moons_repository.dart';

class GetAllMoonsByPlanetUseCase {
  final MoonsRepository repository;

  GetAllMoonsByPlanetUseCase(this.repository);

  Future<List<Moon>> call(String planetId) async{
    return repository.getAllMoonsByPlanet(planetId);
  }
}