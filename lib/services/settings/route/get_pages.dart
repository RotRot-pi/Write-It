import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:write_it/services/settings/route/routes.dart';

import '../../../screens/screens.dart';

class GoRoutes {
  static routerFunction(
    var navigatorKey,
    AsyncValue<User?> authState,
  ) {
    final GoRouter router = GoRouter(
        errorBuilder: (context, state) => ErrorScreen(error: state.error),
        navigatorKey: navigatorKey,
        initialLocation: Routes.authenticationPath,
        debugLogDiagnostics: true,
        routes: [
          GoRoute(
            path: Routes.authenticationPath,
            name: Routes.authenticationName,
            builder: (context, state) => const AuthenticationScreen(),
          ),
          GoRoute(
            path: Routes.homePath,
            name: Routes.homeName,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: Routes.addNotePath,
            name: Routes.addNoteName,
            pageBuilder: (context, state) => CustomTransitionPage(
              transitionDuration: const Duration(milliseconds: 250),
              child: AddNoteScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: AddNoteScreen(),
              ),
            ),
          ),
          GoRoute(
            path: Routes.viewNotePath,
            name: Routes.viewNoteName,
            pageBuilder: (context, state) => CustomTransitionPage(
                transitionDuration: const Duration(milliseconds: 350),
                child: ViewNoteScreen(
                  noteInfo: state.extra as Map,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(
                          opacity: CurvedAnimation(
                            parent: animation,
                            curve: Curves.fastOutSlowIn,
                          ),
                          child: ViewNoteScreen(
                            noteInfo: state.extra as Map,
                          ),
                        )),
          ),
          GoRoute(
            path: Routes.editNotePath,
            name: Routes.editNoteName,
            pageBuilder: (context, state) => CustomTransitionPage(
              transitionDuration: const Duration(milliseconds: 250),
              child: EditNoteScreen(
                noteInfo: state.extra as Map,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: EditNoteScreen(
                  noteInfo: state.extra as Map,
                ),
              ),
            ),
          ),
        ],
        redirect: ((context, state) {
          if (authState.isLoading || authState.hasError) return null;
          final isAuth = authState.valueOrNull != null;
          final isLogin = state.location == Routes.authenticationPath;

          if (isLogin) {
            return isAuth ? Routes.homePath : null;
          }

          return null;
        }));
    return router;
  }
}
