import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../functions/crud_functions.dart';



final fireStoreNotesProvider = Provider.autoDispose<FirebaseCRUD>(
  (ref) {
    ref.onDispose(() {
      log('notesProvider is disposed');
    });
    return FirebaseCRUD();
  },
);
final notesProvider =
    StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>(
  (ref) {
    ref.onResume(() {
      log('notesProvider is resumed');
    });
    ref.onDispose(() {
      log('notesProvider is disposed');
    });
    final notes = ref.read(fireStoreNotesProvider).readNotes();
    return notes;
  },
);
