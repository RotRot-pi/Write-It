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
          ),
          GoRoute(
            path: Routes.addNotePath,
            name: Routes.addNoteName,
            pageBuilder: (context, state) => CustomTransitionPage(
              transitionDuration: const Duration(milliseconds: 350),
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
            // builder: (context, state) => ViewNoteScreen(
            //   noteInfo: state.extra as Map,
            // ),
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

class ScaleTrasitionWidget extends StatefulWidget {
  ScaleTrasitionWidget({
    Key? key,
    required this.animation,
  }) : super(key: key);
  Animation<double> animation;

  @override
  State<ScaleTrasitionWidget> createState() => _ScaleTrasitionWidgetState();
}

class _ScaleTrasitionWidgetState extends State<ScaleTrasitionWidget> {
  final Tween<double> _tween = Tween<double>(
    begin: 0.0,
    end: 1.0,
  );

  //  AnimatedWidget(
  //   tween: _tween,
  //   child: Container(),
  //   duration: Duration(milliseconds: 500),
  // );

  @override
  Widget build(BuildContext context) {
    final AnimatedWidget animatedWidget = ScaleTransition(
        scale: CurvedAnimation(
          parent: widget.animation,
          curve: Curves.fastOutSlowIn,
        ),
        child: Container());
    return animatedWidget;

    // return ScaleTransition(
    //   scale: CurvedAnimation(
    //     parent: widget.animation,
    //     curve: Curves.fastOutSlowIn,
    //   ),
    // );
  }
}
