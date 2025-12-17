import 'package:app_rest/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:app_rest/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app_rest/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app_rest/features/auth/domain/usecases/createUser_usecase.dart';
import 'package:app_rest/features/auth/domain/usecases/verifyUser_usecase.dart';
import 'package:app_rest/features/astro/data/datasource/planet_remote_data_source.dart';
import 'package:app_rest/features/astro/data/repositories/planet_repository_impl.dart';
import 'package:app_rest/features/astro/domain/usecases/get_all_planets_use_case.dart';
import 'package:app_rest/features/astro/domain/usecases/get_planet_of_day_use_case.dart';
import 'package:app_rest/features/user/data/datasource/user_remote_data_source.dart';
import 'package:app_rest/features/user/data/repository/user_repository_impl.dart';
import 'package:app_rest/features/user/domain/usecases/delete_account_use_case.dart';
import 'package:app_rest/features/user/domain/usecases/get_profile_use_case.dart';
import 'package:app_rest/features/user/domain/usecases/logout_use_case.dart';
import 'package:app_rest/main_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  AndroidOptions getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  final secureStorage = FlutterSecureStorage(aOptions: getAndroidOptions());

  final authLocalDataSource = AuthLocalDataSourceImpl(storage: secureStorage);
  final authRemoteDataSource = AuthRemoteDataSourceImpl();
  final userRemoteDataSource = UserRemoteDataSourceImpl();
  final planetDataSource = PlanetRemoteDataSourceImpl();
  
  final authRepository = AuthRepositoryImpl(
    remoteDataSource: authRemoteDataSource,
    localDataSource: authLocalDataSource,
  );
  final userRepository = UserRepositoryImpl(remoteDataSource: userRemoteDataSource, localDataSource: authLocalDataSource);
  final planetRepository = PlanetRepositoryImpl(remoteDataSource: planetDataSource);

  final createUserUseCase = CreateuserUsecase(authRepository);
  final verifyUserUseCase = VerifyuserUsecase(authRepository);
  final getAllPlanetsUseCase = GetAllPlanetsUseCase(planetRepository);
  final getPlanetOfDayUseCase = GetPlanetOfDayUseCase(planetRepository);
  final getProfileUseCase = GetProfileUseCase(userRepository);
  final deleteAccountUseCase = DeleteAccountUseCase(userRepository);
  final logoutUseCase = LogoutUseCase(userRepository); 
  
  runApp(
    MainApp(
      createUserUseCase: createUserUseCase,
      verifyUserUseCase: verifyUserUseCase,
      getAllPlanetsUseCase: getAllPlanetsUseCase,
      getPlanetOfDayUseCase: getPlanetOfDayUseCase,
      getProfileUseCase: getProfileUseCase,
      deleteAccountUseCase: deleteAccountUseCase,
      logoutUseCase: logoutUseCase,
    ),
  );
}