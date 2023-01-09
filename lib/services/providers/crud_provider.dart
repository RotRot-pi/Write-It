import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../functions/functions.dart';

import '../models/note.dart';

final fireCrudProvider = Provider.autoDispose<FirebaseCRUD>((ref) {
  ref.onDispose(() {
    log('fireCrudProvider is disposed');
  });
  return FirebaseCRUD();
});
final noteProvider =
    StateNotifierProvider.autoDispose<NoteNotifier, List<NoteModel>>((ref) {
  ref.onDispose(() {
    log('noteProvider is disposed');
  });
  return NoteNotifier();
});

class NoteNotifier extends StateNotifier<List<NoteModel>> {
  NoteNotifier() : super([]);
  //for local storage
  addNote(NoteModel note) {
    state = [...state, note];
  }
}

final isSaved = StateProvider.autoDispose<bool>((ref) {
  ref.onDispose(() {
    log('isSaved is disposed');
  });
  return false;
});
