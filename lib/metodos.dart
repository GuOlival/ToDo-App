


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Metodos {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  createTodos(String input, String uid) {
    DocumentReference documentReference = firestore.collection(uid).doc(input);
    Map<String, dynamic>todos = {
      "todoTitle": input
    };
    documentReference.set(todos).whenComplete(() => print("$input created"));
  }

  deleteTodos(String input, String uid) {
    DocumentReference documentReference = firestore.collection(uid).doc(input);
    documentReference.delete().whenComplete(() => print("$input deleted"));
  }

   createAlertDialog(String input, BuildContext context, String uid){
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Text("Add Todolist"),
      content: TextField(
        onChanged: (String value){
        input = value;
        },
      ),
      actions: <Widget>[
        FlatButton(
        onPressed: (){createTodos(input, uid); Navigator.pop(context);},
        child: Text("Add"))
        ],
    );
  }



}
