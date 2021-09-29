import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noa/customWidgets/showAlertDialog.dart';
import 'package:noa/services/Auth.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatelessWidget {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure that you want to Logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    );
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return
      Scaffold(
        appBar: AppBar(
          actions: [TextButton(onPressed:()=> _confirmSignOut(context),
              child: Text('Logout', style:
                TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'IndieFlower',
                  fontSize: 20,
                  color: Colors.white
                ),))],
          title: Row(
            children: [
              Text(
                'Splant',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'IndieFlower', fontSize: 30),
              ),
              Icon(FontAwesomeIcons.leaf,
                size: 12,
                color: Colors.white70,
              )
            ],
          ),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user.photoURL),

                ),
                SizedBox(height: 15,),
                Text(
                  ''+user.displayName,
                  style: TextStyle(fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IndieFlower',
                      letterSpacing: 2,
                      color: Colors.green[800]
                  ),
                ),
                SizedBox(height: 15,),
                Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(CupertinoIcons.envelope, size: 20,),
                    ),
                  Text(
                    user.email,
                    style: TextStyle(fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        fontFamily: 'IndieFlower',
                        color: Colors.green[800],
                    ),
                  ),],
                ),
              ],
            ),
          ),
        ),
      );
  }
}
