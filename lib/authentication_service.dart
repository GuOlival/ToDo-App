
//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService{
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }

  Future<String> passwordReset({String email, BuildContext context}) async{
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Recuperação enviada pro e-mail')));
    } on FirebaseAuthException catch(e){
      print(e.message);
    }

  }
  Future<String> signIn({String email, String password, BuildContext context}) async {
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: (email), password: password);
      return "Signed In";
    }on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Conta não existe ')));
      print("Sem registro");
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: (email), password: password);
      print("Registrado");
      return "Signed Up";
    }on FirebaseAuthException catch(e){
      return e.message;
    }
  }

  Future<void> resetPassword(String email) async{
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }


}