


import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Metodos {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  createTodos(String input, String uid, String diaEscolhido, String horarioEscolhido, String ano, String mes) {
    DocumentReference documentReference = firestore.collection("users").doc(uid).collection('tasks').doc(input);

    Map<String, dynamic>todos = {
      "todoTitle": input,
      "dia": diaEscolhido,
      "horario": horarioEscolhido,
      "ano": ano,
      "mes": mes
    };
    documentReference.set(todos).whenComplete(() => print("$input created"));
  }

  deleteTodos(String input, String uid) {
    DocumentReference documentReference = firestore.collection('users').doc(uid).collection('tasks').doc(input);
    documentReference.delete().whenComplete(() => print("$input deleted"));
  }






}
