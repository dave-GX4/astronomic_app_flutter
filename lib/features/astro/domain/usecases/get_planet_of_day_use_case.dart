import 'package:app_rest/features/astro/domain/repositories/planets_repository.dart';
import 'package:app_rest/features/astro/domain/entities/planent.dart';

class GetPlanetOfDayUseCase {
  final PlanetsRepository repository;

  GetPlanetOfDayUseCase(this.repository);

  Future<Planet> call() async {
    return await repository.getPlanetOfTheDay();
  }
}