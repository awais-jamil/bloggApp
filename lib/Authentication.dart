import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthImplementation{

  Future<String> SignIn(String email, String password);
  Future<String> SignUp(String email, String password);
  Future<String> GetCurrentUser();
  Future<void> SignOut();
}

class Auth implements AuthImplementation{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> SignIn(String email, String password) async {

    AuthResult  result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    final FirebaseUser user = result.user;
    print('signInEmail succeeded: $user');
    return user.uid;
  }

  Future<String> SignUp(String email, String password) async {

    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password) as FirebaseUser;

    return user.uid;
  }

  Future<String> GetCurrentUser() async {

    FirebaseUser user = await _firebaseAuth.currentUser();

    return user.uid;
  }

  Future<void> SignOut() async {
    _firebaseAuth.signOut();
  }

}