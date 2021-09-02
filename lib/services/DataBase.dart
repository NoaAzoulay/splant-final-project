import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noa/models/plant.dart';
import 'package:noa/services/API_Path.dart';

import 'firestoreService.dart';
//common API so it can be scalable

abstract class DataBase {
  Future<void> addNewPlant(Plant plant);
  Stream<List<Plant>> plantsStream();

}

class FirestoreDataBase implements DataBase {
  final String uid;
  final _service= FireStoreService.instance;

  FirestoreDataBase({this.uid}) : assert(uid != null);


  Future<void> addNewPlant(Plant plant) =>
      _service.setData(
        path: APIPath.plant(uid, 'plant_123'),
        data: plant.toMap(),
      );


//read collection as a stream
  Stream<List<Plant>> plantsStream() =>
      _service.collectionStream(
        path: APIPath.plants(uid),
        builder: (data) => Plant.fromMap(data),
      );




}