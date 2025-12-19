import 'package:app_rest/features/astro/data/datasource/moon_remote_data_source.dart';
import 'package:app_rest/features/astro/data/datasource/planet_remote_data_source.dart';
import 'package:app_rest/features/astro/data/repositories/moon_repository_impl.dart';
import 'package:app_rest/features/astro/data/repositories/planet_repository_impl.dart';
import 'package:app_rest/features/astro/domain/repositories/moons_repository.dart';
import 'package:app_rest/features/astro/domain/repositories/planets_repository.dart';
import 'package:app_rest/features/astro/domain/usecases/get_all_moons_by_planet_use_case.dart';
import 'package:app_rest/features/astro/domain/usecases/get_all_moons_use_case.dart';
import 'package:app_rest/features/astro/domain/usecases/get_all_planets_use_case.dart';
import 'package:app_rest/features/astro/domain/usecases/get_by_id_planet_use_case.dart';
import 'package:app_rest/features/astro/domain/usecases/get_planet_of_day_use_case.dart';
import 'package:app_rest/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:app_rest/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app_rest/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app_rest/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_rest/features/auth/domain/usecases/createUser_usecase.dart';
import 'package:app_rest/features/auth/domain/usecases/verifyUser_usecase.dart';
import 'package:app_rest/features/user/data/datasource/user_remote_data_source.dart';
import 'package:app_rest/features/user/data/repository/user_repository_impl.dart';
import 'package:app_rest/features/user/domain/repository/user_repository.dart';
import 'package:app_rest/features/user/domain/usecases/delete_account_use_case.dart';
import 'package:app_rest/features/user/domain/usecases/edit_profile_use_case.dart';
import 'package:app_rest/features/user/domain/usecases/get_profile_use_case.dart';
import 'package:app_rest/features/user/domain/usecases/logout_use_case.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> init() async {
  // Use Cases
  sl.registerLazySingleton(() => CreateuserUsecase(sl()));
  sl.registerLazySingleton(() => VerifyuserUsecase(sl()));
  sl.registerLazySingleton(() => EditProfileUseCase(sl()));
  sl.registerLazySingleton(() => GetAllPlanetsUseCase(sl()));
  sl.registerLazySingleton(() => GetPlanetOfDayUseCase(sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetByIdPlanetUseCase(sl()));
  sl.registerLazySingleton(() => GetAllMoonsByPlanetUseCase(sl()));
  sl.registerLazySingleton(() => GetAllMoonsUseCase(sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );
  sl.registerLazySingleton<PlanetsRepository>(
    () => PlanetRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<MoonsRepository>(
    () => MoonRepositoryImpl(remoteDataSource: sl())
  );

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(storage: sl()),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<PlanetRemoteDataSource>(
    () => PlanetRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<MoonRemoteDataSource>(
    () => MoonRemoteDataSourceImpl()
  );

  // Core
  const androidOptions = AndroidOptions(encryptedSharedPreferences: true);
  sl.registerLazySingleton(() => FlutterSecureStorage(aOptions: androidOptions));
}