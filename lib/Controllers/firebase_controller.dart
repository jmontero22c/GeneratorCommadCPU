import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
    FirebaseFirestore database = FirebaseFirestore.instance;

class FirestoreCloud {
  final FirebaseFirestore database = FirebaseFirestore.instance;

  Future<void> saveValuesDatabase(String? command, List<String> listNames, List<TextEditingController> listValues) async {    
    if (command == null) {return;}
    command = "[$command]";
    DocumentReference docRef = database.collection('Comandos').doc(command);

    Map<String, dynamic> updates = {};
    for (int i = 0; i < listNames.length; i++) {
      updates["${i+1}_${listNames[i]}"] = listValues[i].text; // Assuming you want the text value from TextEditingController
    }

    try {
      await docRef.update(updates);
      log("Data updated successfully!");
    } catch (e) {
      log("Failed to update data: $e");
    }

  }


  Future<int> getLength(String command) async { 
    int len = 0;

    DocumentReference docref = database.collection('Comandos').doc(command);  
    try {
      await docref.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        len = data.length;
        log('Length of the data: $len');
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
          log('Data read succesfully');
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
