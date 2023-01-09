import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../settings/route/routes.dart';

class FirebaseCRUD {
  final _firestore = FirebaseFirestore.instance;

  final User? currentUser = FirebaseAuth.instance.currentUser;
  addNote(BuildContext context,
      {String? title,
      String? description,
      String? date,
      String? time,
      var ref}) async {
    _firestore.settings =
        const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
    final CollectionReference collection = _firestore.collection('users-notes');
    await collection.doc(currentUser!.uid).collection('notes').add({
      'title': title,
      'description': description,
      'date': date,
      'time': time,
    }).then((value) => context.pop(),
        onError: (e) => log('error after adding:$e'));
  }

  Future<void> deleteNote(String id, var context) async {
    final CollectionReference collection = _firestore.collection('users-notes');
    await collection.doc(currentUser!.uid).collection('notes').doc(id).delete();
  }

  updateNote(
    String id,
    BuildContext context, {
    String? title,
    String? description,
    String? date,
    String? time,
  }) async {
    final CollectionReference collection = _firestore.collection('users-notes');
    await collection.doc(currentUser!.uid).collection('notes').doc(id).update({
      'title': title,
      'description': description,
      'date': date,
      'time': time,
    }).then((value) => context.go(Routes.homePath));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readNotes() async* {
    final CollectionReference collection = _firestore.collection('users-notes');
    var notesDocuments =
        collection.doc(currentUser!.uid).collection('notes').snapshots();

    yield* notesDocuments;
  }
}
