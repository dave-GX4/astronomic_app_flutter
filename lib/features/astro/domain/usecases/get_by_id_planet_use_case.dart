import 'package:app_rest/features/astro/domain/entities/planent.dart';
import 'package:app_rest/features/astro/domain/repositories/planets_repository.dart';

class GetByIdPlanetUseCase {
  final PlanetsRepository repository;

  GetByIdPlanetUseCase(this.repository);

  Future<Planet> call(String id) async {
    return await repository.getByIdPlanet(id);
  }
}