import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addRecipe(Map<String, dynamic> task) async {
    await _db.collection('recipes').add(task).then((DocumentReference doc) {
      print('DocumentSnapshot added with ID: ${doc.id}');
    });
  }

  static Future<void> updateRecipe(String id, Map<String, dynamic> task) async {
    await _db.collection('recipes').doc(id).update(task).catchError((e) {
      print(e);
    });
  }

  static Future<void> deleteRecipe(String id) async {
    await _db.collection('recipes').doc(id).delete().catchError((e) {
      print(e);
    });
  }
}
