import 'package:app_rest/core/di/di.dart';
import 'package:app_rest/core/router/router.dart';
import 'package:app_rest/features/astro/domain/usecases/get_all_moons_by_planet_use_case.dart';
import 'package:app_rest/features/astro/domain/usecases/get_all_moons_use_case.dart';
import 'package:app_rest/features/astro/domain/usecases/get_by_id_planet_use_case.dart';
import 'package:app_rest/features/astro/presentation/providers/planet_details_provider.dart';
import 'package:app_rest/features/user/domain/usecases/logout_use_case.dart';
import 'package:app_rest/features/auth/domain/usecases/createUser_usecase.dart';
import 'package:app_rest/features/auth/domain/usecases/verifyUser_usecase.dart';
import 'package:app_rest/features/user/domain/usecases/get_profile_use_case.dart';
import 'package:app_rest/features/user/domain/usecases/edit_profile_use_case.dart';
import 'package:app_rest/features/user/domain/usecases/delete_account_use_case.dart';
import 'package:app_rest/features/astro/domain/usecases/get_all_planets_use_case.dart';
import 'package:app_rest/features/astro/domain/usecases/get_planet_of_day_use_case.dart';
import 'package:app_rest/features/auth/presentation/providers/login_provider.dart';
import 'package:app_rest/features/auth/presentation/providers/registre_provider.dart';
import 'package:app_rest/features/astro/presentation/providers/home_provider.dart';
import 'package:app_rest/features/user/presentation/provider/edit_profile_provider.dart';
import 'package:app_rest/features/user/presentation/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Inyectamos usando sl<Clase>()
        ChangeNotifierProvider(
          create: (_) => RegistreProvider(sl<CreateuserUsecase>()),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(sl<VerifyuserUsecase>()),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(
            getAllPlanetsUseCase: sl<GetAllPlanetsUseCase>(),
            getPlanetOfDayUseCase: sl<GetPlanetOfDayUseCase>(), 
            getAllMoonsUseCase: sl<GetAllMoonsUseCase>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AstroItemProvider(
            getByIdPlanetUseCase: sl<GetByIdPlanetUseCase>(), 
            getAllMoonsByPlanetUseCase: sl<GetAllMoonsByPlanetUseCase>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(
            getProfileUseCase: sl<GetProfileUseCase>(), 
            logoutUseCase: sl<LogoutUseCase>(), 
            deleteAccountUseCase: sl<DeleteAccountUseCase>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => EditProfileProvider(
            editProfileUseCase: sl<EditProfileUseCase>(),
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Astronomía Registro',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF101622),
          primaryColor: const Color(0xFF135bec),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF135bec),
            secondary: Color(0xFF135bec),
          ),
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}