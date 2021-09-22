
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noa/models/plant.dart';

class FirestoreDB {
  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static final plantsDB = firebaseFirestore.collection('plants');
 // static final usersDB = firebaseFirestore.collection('users').doc('uid').collection('plants');

  static Future<List<Plant>> getPlants() async {
    // get the data from DB
    final data = await plantsDB.get();
    // Convert from MAP to Plant object
    final List<Plant> plantsList =
    data.docs.map((e) => Plant.fromMap(e.data(),e.id)).toList();
    return plantsList;
  }

  // static Future<List<Plant>> getUserPlants() async {
  //   // get the data from DB
  //   final data = await usersDB.get();
  //   // Convert from MAP to Plant object
  //   final List<Plant> plantsList =
  //   data.docs.map((e) => Plant.fromMap(e.data())).toList();
  //   return plantsList;
  // }



}
