import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noa/models/plant.dart';
import 'package:noa/services/API_Path.dart';
import 'firestoreService.dart';
//common API so it can be scalable

abstract class DataBase {
  Future<void> addNewCustomPlant(Plant plant);
  Future<void> deletePlant(Plant plant);
  Future<void> addNewPlant( String uid,Plant plant);
  Stream<List<Plant>> plantsStream();

}
//generating unique id
String docIdFromCurrentDate()=>DateTime.now().toIso8601String();

class FirestoreDataBase implements DataBase {
  final String uid;
  final _service= FireStoreService.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final user = FirebaseAuth.instance.currentUser;


  FirestoreDataBase({this.uid}) : assert(uid != null);

//user add custom plant
  Future<void> addNewCustomPlant(Plant plant) =>
      _service.setData(
        path: APIPath.customPlant(uid, docIdFromCurrentDate()),
        data: plant.toMap(),
      );

//user add plant from existing plant list in db
  Future<void> addNewPlant(String uid,Plant plant) =>
      _service.setData(
        path: APIPath.plant(uid, docIdFromCurrentDate()),
        data: plant.toMap(),
      );

//user delete plant from list
 Future<void> deletePlant(Plant plant) async => _service.deletePlant(
   APIPath.plant(uid, plant.id)
 );


//read collection as a stream
  Stream<List<Plant>> plantsStream() =>
      _service.collectionStream(
        path: APIPath.plants(uid),
        builder: (data, docID) => Plant.fromMap(data, docID),
      );






}