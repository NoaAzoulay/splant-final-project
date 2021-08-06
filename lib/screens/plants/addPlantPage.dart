import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noa/services/firestoreService.dart';


class AddPlant extends StatefulWidget{


  static Future<void> show(BuildContext context)async{
    await Navigator.of(context).push(
      MaterialPageRoute(
      builder: (context)=> AddPlant(),
      fullscreenDialog: true
      ),
    );
  }
  @override
  _AddPlantState createState()=> _AddPlantState();
}



class _AddPlantState extends State<AddPlant>{


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.green,
        title: Text('New Plant'),
      ),
      body: _buildContent(),
    );
  }

//show a list of plants names so one can be chosen
 Widget _buildContent() {
  // final Stream<QuerySnapshot> plantsList =
  // FirebaseFirestore.instance.collection('plants').snapshots();
  //
  // StreamBuilder<QuerySnapshot>
  //   (stream: plants,
  //   builder: context, AsyncSnapshot<QuerySnapshot> snapshot,){
  //   final data = snapshot.requireData;
  //   return ListView.builder(
  //     itemCount: data.size,
  //     itemBuilder: (context, index) {
  //       return Text('${data.docs[index]['name']}');
  //     },
  //   );
  }



 }




