import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noa/customWidgets/BottomNavigationBar.dart';
import 'package:noa/services/Auth.dart';
import 'package:noa/services/DataBase.dart';
import 'package:noa/services/signIn/sign_in_up.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return SignInUp.create(context);
          }
          return Provider<DataBase>(
            create: (_)=> FirestoreDataBase(
              uid: user.uid),
              child: BottomNavigation(),
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
