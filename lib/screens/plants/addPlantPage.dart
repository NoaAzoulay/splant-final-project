import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noa/common_widgets/showExceptionAlertDialog.dart';
import 'package:noa/models/plant.dart';
import 'package:noa/models/user.dart';
import 'package:noa/screens/plants/plantsDetailsCard.dart';
import 'package:noa/services/DataBase.dart';
import 'package:noa/services/myClient.dart';
import 'package:noa/services/firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddPlant extends StatefulWidget {
  Plant plant;
  DataBase dataBase;

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => AddPlant(), fullscreenDialog: true),
    );
  }

  @override
  _AddPlantState createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  Future getPlantsFuture = FirestoreDB.getPlants();
  MyClient client= MyClient.instance;
  List<Plant> plants;
  User currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.green,
        title: Text('Choose Plant'),
      ),
      body: _buildContent(),
    );
  }

//show a list of plants names so one can be chosen
  Widget _buildContent() {
    return FutureBuilder<List<Plant>>(
      future: getPlantsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData) {
          return Center(
            child: AlertDialog(
              title: Text('Error'),
              content: Text('No Data'),
            ),
          );
        }
        plants = snapshot.data;
        return ListView.builder(
            itemCount: plants.length,
            itemBuilder: (context, i) => ListTile(
                  selectedTileColor: Colors.green[200],
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      plants[i].image,
                    ),
                  ),
                  title: Text(
                    plants[i].name,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'IndieFlower',
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                  trailing: SizedBox(
                    height: 27,
                    width: 25,
                    child: IconButton(
                        icon: Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.green,
                        ),
                        onPressed: () => addSerialNum(context, i)),
                  ),
//when tapping the plants name
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => PlantsDetails(
                          plant: plants[i],
                        ),
                      ),
                    );
                  },
                ));
      },
    );
  }




  Future<void> addPlantToUserList(Plant plant, String num) async {
    try {
      users.doc(currentUser.uid).collection('plants').doc(plant.id).set({
        'name': plant.name,
        'image': plant.image,
        'Soil Humidity': plant.soilHumidity,
        'Air Humidity': plant.airHumidity,
        'UV': plant.uv,
        'Temperature': plant.tmp,
        'serial': num,
      }).then((value) => print(num));
      Navigator.of(context).pop();
      client.notifyServerFlowerBoxAdded(num, plant);
    } on FirebaseException catch (e) {
      showExceptionAlertDialog(context,
          title: 'An Error occurred, please try again', exception: e);
    }
  }

  void addSerialNum(context, i) {
    String serialNum;
    Alert(
        context: context,
        title: "Insert Splant-box number:",
        style: AlertStyle(
          titleStyle: TextStyle(
              fontFamily: 'IndieFlower',
              fontSize: 25,
              color: Colors.green[800],
              fontWeight: FontWeight.bold,
              letterSpacing: 2),
        ),
        content: Column(
          children: <Widget>[
            TextField(
              onChanged: (String val) => serialNum = val,
              decoration: InputDecoration(
                  helperText: ' Find it on your box\'es side ',
                  helperStyle: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontFamily: 'IndieFlower',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2)),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.green[800],
            onPressed: () => addPlantToUserList(plants[i], serialNum),
            child: Text(
              "submit",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'IndieFlower',
                  letterSpacing: 2),
            ),
          )
        ]).show();
  }




}
