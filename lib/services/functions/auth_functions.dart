import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:write_it/utils/constants.dart';

class Authentication {
  final _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  signUpMethode(
    BuildContext context,
    GlobalKey<FormState>? formState,
    var username,
    var email,
    var password,
  ) async {
    var formData = formState!.currentState!;

    if (formData.validate()) {
      formData.save();

      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        log('connection State ');
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'email': userCredential.user!.email,
          'username': username,
        });

        log("signUp done");
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          await errorDialog(context, e.message);

          log('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          await errorDialog(context, e.message);
          log('The account already exists for that email.');
        }
        log(e.code);
      } catch (e) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => Center(child: Text('error:$e')))));
        log('e: $e');
      }
    } else if (!formData.validate()) {
      await invalidDialog(context, 'Fill the field correcly please');
    } else {
      Navigator.pop(context);
    }
  }

  loginMethode(
    BuildContext context,
    GlobalKey<FormState> formState,
    var email,
    var password,
  ) async {
    var formData = formState.currentState;

    if (formData!.validate()) {
      formData.save();

      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          await errorDialog(context, e.message);
          log('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          await errorDialog(context, e.message);
          log('Wrong password provided for that user.');
        } else if (e.code == 'unknown') {
          log('error message:${e.message}');
        }
        log(e.code);
      } catch (e) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => Center(child: Text('error:$e')))));
        log('error in log in :$e');
      }
    } else if (!formData.validate()) {
      await invalidDialog(context, 'Fill the field correcly please');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
