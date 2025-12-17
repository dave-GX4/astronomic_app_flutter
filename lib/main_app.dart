import 'package:app_rest/core/router/router.dart';
import 'package:app_rest/features/auth/domain/usecases/createUser_usecase.dart';
import 'package:app_rest/features/auth/domain/usecases/verifyUser_usecase.dart';
import 'package:app_rest/features/auth/presentation/providers/login_provider.dart';
import 'package:app_rest/features/auth/presentation/providers/registre_provider.dart';
import 'package:app_rest/features/astro/domain/usecases/get_all_planets_use_case.dart';
import 'package:app_rest/features/astro/domain/usecases/get_planet_of_day_use_case.dart';
import 'package:app_rest/features/astro/presentation/providers/home_provider.dart';
import 'package:app_rest/features/user/domain/usecases/delete_account_use_case.dart';
import 'package:app_rest/features/user/domain/usecases/get_profile_use_case.dart';
import 'package:app_rest/features/user/domain/usecases/logout_use_case.dart';
import 'package:app_rest/features/user/presentation/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  final CreateuserUsecase createUserUseCase;
  final VerifyuserUsecase verifyUserUseCase;
  final GetAllPlanetsUseCase getAllPlanetsUseCase;
  final GetPlanetOfDayUseCase getPlanetOfDayUseCase;
  final GetProfileUseCase getProfileUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final LogoutUseCase logoutUseCase;

  const MainApp({
    super.key, 
    required this.createUserUseCase,
    required this.verifyUserUseCase,
    required this.getAllPlanetsUseCase,
    required this.getPlanetOfDayUseCase,
    required this.getProfileUseCase,
    required this.deleteAccountUseCase,
    required this.logoutUseCase
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RegistreProvider(createUserUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(verifyUserUseCase),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(
            getAllPlanetsUseCase: getAllPlanetsUseCase,
            getPlanetOfDayUseCase: getPlanetOfDayUseCase,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(
            getProfileUseCase: getProfileUseCase, 
            logoutUseCase: logoutUseCase, 
            deleteAccountUseCase: deleteAccountUseCase
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Astronomía Registro',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101622),
          primaryColor: Color(0xFF135bec),
          colorScheme: ColorScheme.dark(
            primary: Color(0xFF135bec),
            secondary: Color(0xFF135bec),
          ),
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}