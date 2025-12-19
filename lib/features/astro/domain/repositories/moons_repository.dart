import 'package:app_rest/features/astro/domain/entities/moon.dart';

abstract class MoonsRepository {
  Future<List<Moon>> getAllMoons();
  Future<List<Moon>> getAllMoonsByPlanet(String planetId);
  Future<Moon> getByIdMoon(String id);
}