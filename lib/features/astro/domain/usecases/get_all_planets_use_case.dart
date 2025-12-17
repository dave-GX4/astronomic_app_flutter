import 'package:app_rest/features/astro/domain/repositories/planets_repository.dart';
import '../entities/planent.dart';

class GetAllPlanetsUseCase {
  final PlanetsRepository repository;

  GetAllPlanetsUseCase(this.repository);

  Future<List<Planet>> call() async {
    return await repository.getAllPlanets();
  }
}