
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService{
  //accessible only by a singleton
  //private cnst
  FireStoreService._();
  //singleton to create only once, get access via instance
  static final instance = FireStoreService._();

  //get DB ref from firestore
  Future<void> setData({String path, Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('$path: $data');
    await reference.set(data);
  }

  Future<void> deletePlant(String path) async{
    final reference = FirebaseFirestore.instance.doc(path);
    print('$path: deleted');
    await reference.delete();
  }

  //getting the collection data from firestore
  Stream<List<T>> collectionStream<T>({
    String path,
    T Function(Map<String, dynamic> data, String docID) builder,
  }) {
    final reference = FirebaseFirestore.instance.collection(path);
    //stream of the data
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) =>
        snapshot.docs.map(
              (snapshot) => builder(snapshot.data(), snapshot.id),
        ).toList());
  }




}