import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'services/services.dart';
import 'utils/utils.dart';









void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCAgWCOu2yUfQr3IetQ4rGiVAx9gQyGQ8o",
          appId: "1:153736884667:web:0cfb94aefdd7c26e75149e",
          messagingSenderId: "153736884667",
          projectId: "write-it-a8391"));
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
































