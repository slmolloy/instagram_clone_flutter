import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_flutter/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty) {
        // Register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        print(cred.user!.uid);

        String url = await StorageMethods().uploadImageToStorage('profilePics', file, false);

        // Add user to database
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'bio': bio,
          'email': email,
          'followers': [],
          'following': [],
          'photoUrl': url,
        });

        res = 'success';
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is badly formatted.';
      } else if (err.code == 'weak-password') {
        res = 'Password should be at least 6 characters.';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
