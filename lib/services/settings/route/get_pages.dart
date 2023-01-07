import 'package:go_router/go_router.dart';

import 'package:write_it/services/settings/route/routes.dart';

import '../../../screens/screens.dart';

class GoRoutes {
  static routerFunction(
    var navigatorKey,
    var authState,
  ) {
    final GoRouter router = GoRouter(
        errorBuilder: (context, state) => ErrorScreen(error: state.error),
        navigatorKey: navigatorKey,
        initialLocation: Routes.splashPath,
        debugLogDiagnostics: true,
        routes: [
          GoRoute(
            path: Routes.splashPath,
            name: Routes.splashName,
            builder: (context, state) => const SplashScreen(),
          ),
          GoRoute(
            path: Routes.authenticationPath,
            name: Routes.authenticationName,
            builder: (context, state) => const AuthenticationScreen(),
          ),
          GoRoute(
            path: Routes.homePath,
            name: Routes.homeName,
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: Routes.addNotePath,
                name: Routes.addNoteName,
                builder: (context, state) => AddNoteScreen(),
              ),
              GoRoute(
                path: Routes.viewNotePath,
                name: Routes.viewNoteName,
                builder: (context, state) => ViewNoteScreen(
                  noteInfo: state.extra as Map,
                ),
              ),
              GoRoute(
                path: Routes.editNotePath,
                name: Routes.editNoteName,
                builder: (context, state) => EditNoteScreen(
                  noteInfo: state.extra as Map,
                ),
              ),
            ],
          ),
        ],
        redirect: ((context, state) {
          if (authState.isLoading || authState.hasError) return null;
          final isAuth = authState.valueOrNull != null;
          final isSplash = state.location == Routes.splashPath;
          final isLogin = state.location == Routes.authenticationPath;

          if (isSplash == true) {
            return isAuth == true ? Routes.homePath : Routes.authenticationPath;
          }
          if (isLogin == true) {
            return isAuth == true ? Routes.homePath : null;
          }

          return isAuth == true ? null : Routes.splashPath;
        }));
    return router;
  }
}
