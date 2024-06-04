import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
    FirebaseFirestore database = FirebaseFirestore.instance;

class FirestoreCloud {
  final FirebaseFirestore database = FirebaseFirestore.instance;

  Future<int> getLength(String command) async { 
    int len = 0;

    DocumentReference docref = database.collection('Comandos').doc(command);  
    try {
      await docref.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        len = data.length;
      },
      onError: (e) => log("Error getting document: $e"),
    );
    } catch (e) {
      log("Something went wrong trying get Length: $e");
    }
    

    return len;
  }

  Future<Map<String, dynamic>> readDatabase(String command) async {
  Map<String, dynamic> data = {"":0};
  try {
    DocumentReference docref = database.collection('Comandos').doc(command);   
    await docref.get().then(
      (DocumentSnapshot doc) {
        data = doc.data() as Map<String, dynamic>;
        return data;
      },
      onError: (e) => log("Error getting document: $e"),
    );

  } catch (e) {
    log("Something went wrong: $e");
  }
  return data;
}
}
