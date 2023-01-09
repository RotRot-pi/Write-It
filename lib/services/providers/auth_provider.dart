import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../functions/auth_functions.dart';

final firebaseAuthProvider = Provider.autoDispose<Authentication>(((ref) {
  ref.onDispose(() {
    log('firebaseAuthProvider is disposed');
  });
  return Authentication();
}));
final authStateProvider = StreamProvider.autoDispose<User?>(
  (ref) {
    ref.onDispose(() {
      log('authStateProvider is disposed');
    });
    return ref.read(firebaseAuthProvider).authStateChanges;
  },
);

final userState = StateProvider.autoDispose((ref) {
  ref.onDispose(() {
    log('userState is disposed');
  });
  final user = ref.read(authStateProvider);
  return user;
});
