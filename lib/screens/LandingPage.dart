import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noa/screens/plants/userPlants.dart';
import 'package:noa/screens/signIn/addUser.dart';
import 'package:noa/screens/signIn/sign_in_up.dart';
import 'package:noa/screens/userScreens/ButtomNavigationBar.dart';
import 'package:noa/screens/userScreens/userProfile.dart';
import 'package:noa/services/Auth.dart';
import 'package:noa/services/DataBase.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return signInUp.create(context);
          }
          return Provider<DataBase>(
            create: (_)=> FirestoreDataBase(
              uid: user.uid),
              child: //HomeScreen()
              //UsersPlants()
            BottomNavigation(),
              //UserProfilePage()
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
