import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/models/user.dart' as model;
import 'package:instagram_flutter/resources/storage_methods.dart';

const String defaultError = 'An error occurred';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    Uint8List? file,
  }) async {
    String res = defaultError;
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        // Register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        String? url;
        if (file != null) {
          url = await StorageMethods().uploadImageToStorage('profilePics', file, false);
        }

        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          photoUrl: url,
          followers: [],
          following: [],
        );

        // Add user to database
        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

        res = 'success';
      } else if (username.isEmpty) {
        res = 'Username required';
      } else if (email.isEmpty) {
        res = 'Email required';
      } else if (password.isEmpty) {
        res = 'Password required';
      }
    } on FirebaseAuthException catch (err) {
      res = err.message ?? err.toString();
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = defaultError;

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'success';
      } else if (email.isEmpty) {
        res = 'Email required';
      } else if (password.isEmpty) {
        res = 'Password required';
      }
    } on FirebaseAuthException catch (err) {
      res = err.message ?? err.toString();
    } catch (err) {
      res = err.toString();
    }

    return res;
  }

  Future<String> logOutUser() async {
    String res = defaultError;

    try {
      await _auth.signOut();
      res = 'success';
    } on FirebaseAuthException catch (err) {
      res = err.message ?? err.toString();
    } catch (err) {
      res = err.toString();
    }

    return res;
  }
}
