import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noa/models/user.dart';

//TODO check how to use
class AddUser extends StatelessWidget {
  final String uid;
  AddUser({this.uid, });

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      child: Text(
        "Add User",
      ),
    );
  }
}