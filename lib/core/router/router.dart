import 'package:app_rest/core/router/routes.dart';
import 'package:app_rest/features/auth/presentation/page/login_page.dart';
import 'package:app_rest/features/auth/presentation/page/registration_page.dart';
import 'package:app_rest/features/astro/presentation/page/home_page.dart';
import 'package:app_rest/features/user/domain/entities/user.dart';
import 'package:app_rest/features/user/presentation/page/edit_profile_page.dart';
import 'package:app_rest/features/user/presentation/page/profile_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter{
  static final GoRouter router = GoRouter(
    initialLocation: Routes.loginPath,
    routes: [
      GoRoute(
        path: Routes.registrePath,
        name: Routes.registre,
        builder: (context, state) => RegistrationPage(),
      ),
      GoRoute(
        path: Routes.loginPath,
        name: Routes.login,
        builder: (context, state) => LoginPage()
      ),
      GoRoute(
        path: Routes.homePath,
        name: Routes.home,
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: Routes.profilePath,
        name: Routes.profile,
        builder: (context, state) => ProfilePage(),
      ),
      GoRoute(
        path: Routes.editProfilePath,
        name: Routes.editProfile,
        builder: (context, state) {
          final userToSend = state.extra as User; 
          return EditProfilePage(user: userToSend);
        },
      ),
    ]
  );
}