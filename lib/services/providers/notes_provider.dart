import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../functions/get_data_function.dart';

final fireStoreNotesProvider = Provider.autoDispose<GetData>(
  (ref) => GetData(),
);
final notesProvider =
    StreamProvider.autoDispose<QuerySnapshot<Map<String, dynamic>>>(
  (ref) {
    final notes = ref.read(fireStoreNotesProvider).getData();
    return notes;
  },
);
