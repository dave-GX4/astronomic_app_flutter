import 'package:app_rest/features/astro/domain/entities/moon.dart';
import 'package:app_rest/features/astro/domain/repositories/moons_repository.dart';

class GetByIdMoonUseCase {
  final MoonsRepository repository;

  GetByIdMoonUseCase(this.repository);

  Future<Moon> call(String id) async{
    return repository.getByIdMoon(id);
  }
}