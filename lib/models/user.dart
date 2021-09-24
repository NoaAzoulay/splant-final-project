import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;


class UserData {
 String userEmail;
 String name;
 String id;
 List<String> userPlantsList;
 final firebaseAuth = FirebaseAuth.instance;

 UserData({
   this.userEmail,
   this.name,
   this.id,
   this.userPlantsList,

 });

 factory UserData.fromFirestorUser(
     cloud_firestore.DocumentSnapshot userSnapshout) {
   return UserData(
     name: userSnapshout['name'],
     id: userSnapshout['id'],
     userEmail: userSnapshout['email'],
     userPlantsList: userSnapshout['plantsList'],
   );
 }


 // User get currentUser => _firebaseAuth.currentUser;
  String getCurrentUserID() {
    return firebaseAuth.currentUser.uid;
}

String getCurrentUserEmail(){
    return firebaseAuth.currentUser.email;
}

String getCurrentUserName(){
    return firebaseAuth.currentUser.displayName;
}

List getPlantsList(){
   return userPlantsList;
}








}

