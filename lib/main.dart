import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'services/services.dart';
import 'utils/utils.dart';

void main() async {
  WidgetsBinding widgetsFlutterBinding =
      WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsFlutterBinding);

  FlutterNativeSplash.remove();

  runApp(const ProviderScope(child: WriteIt()));
}

class WriteIt extends ConsumerWidget {
  const WriteIt({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
    final authState = ref.watch(authStateProvider);

    return MaterialApp.router(
      title: 'Write It',
      theme: darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: GoRoutes.routerFunction(navigatorKey, authState),
    );
  }
}
