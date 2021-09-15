import 'package:firebase_auth/firebase_auth.dart';

class userData {
 // var userUid ;

  final _firebaseAuth = FirebaseAuth.instance;



  User get currentUser => _firebaseAuth.currentUser;



}
