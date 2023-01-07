import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../functions/functions.dart';

import '../models/note.dart';

final fireCrudProvider = Provider<FirebaseCRUD>((ref) => FirebaseCRUD());
final noteProvider =
    StateNotifierProvider.autoDispose<NoteNotifier, List<NoteModel>>(
        (ref) => NoteNotifier());

class NoteNotifier extends StateNotifier<List<NoteModel>> {
  NoteNotifier() : super([]);
  //for local storage
  addNote(NoteModel note) {
    state = [...state, note];
  }
}

final isSaved = StateProvider<bool>((ref) {
  return false;
});
