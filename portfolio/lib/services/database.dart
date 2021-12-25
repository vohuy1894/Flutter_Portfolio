import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/pages/home.dart';
import 'package:portfolio/pages/log_in_out/login.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future logOut(BuildContext context) async {
    //FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _firebaseAuth.signOut().then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => SignIn()));
      });
      print("Signed out");
    } catch (e) {
      print("error");
    }
  }

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      print('Logged in');
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      }
      print("This is the error" + e.code);
      return (e.message.toString());
    }
  }

  Future<String> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  
}

