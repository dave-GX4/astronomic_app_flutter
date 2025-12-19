import 'package:app_rest/features/astro/domain/entities/moon.dart';
import 'package:app_rest/features/astro/domain/repositories/moons_repository.dart';

class GetAllMoonsUseCase {
  final MoonsRepository repository;

  GetAllMoonsUseCase(this.repository);

  Future<List<Moon>> call() async{
    return repository.getAllMoons();
  }
}