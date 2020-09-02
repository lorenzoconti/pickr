import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  //
  /// Logs the user in the application
  ///
  /// Given a [username] and a [password], if they are valid, logs the user
  /// in the applicatio. Returns the id of the logged user.
  Future<String> signInWithEmailAndPassword({String email, String password});

  /// Creates a user with given [username] and [password]
  ///
  /// If not exists, creates a user entry in the database and logs it in
  /// the application.
  Future<String> createUserWithEmailAndPassword(
      {String email, String password});

  /// Returns the currently logged in user id.
  Future<String> currentUser();

  /// Signs out the current user.
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> signInWithEmailAndPassword(
      {String email, String password}) async {
    final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return result?.user?.uid;
  }

  @override
  Future<String> createUserWithEmailAndPassword(
      {String email, String password}) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return result?.user?.uid;
  }

  @override
  Future<String> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return user?.uid;
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
