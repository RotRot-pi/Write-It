import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetData {
  final _firestore = FirebaseFirestore.instance;
  final User? currentUser = FirebaseAuth.instance.currentUser;
  Stream<QuerySnapshot<Map<String, dynamic>>> getData() async* {
    final CollectionReference collection = _firestore.collection('users-notes');
    var notesDocuments =
         collection.doc(currentUser!.uid).collection('notes').snapshots();

    yield* notesDocuments;
  }
}

