import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../functions/auth_functions.dart';

final firebaseInitializeProvider = FutureProvider.autoDispose(
  (ref) async {
    return await Firebase.initializeApp();
  },
);
final firebaseAuthProvider =
    Provider.autoDispose<Authentication>(((ref) => Authentication()));
final authStateProvider = StreamProvider.autoDispose<User?>(
  (ref) {
    return ref.read(firebaseAuthProvider).authStateChanges;
  },
);

final userState = StateProvider((ref) {
  final user = ref.read(authStateProvider);
  return user;
});
