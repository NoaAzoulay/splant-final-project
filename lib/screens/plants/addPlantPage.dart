import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noa/models/plant.dart';
import 'package:noa/screens/plants/plantsDetails.dart';
import 'package:noa/services/API_Path.dart';
import 'package:noa/services/firestore.dart';

class AddPlant extends StatefulWidget {
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
  List<Plant> plants;
  List<Plant> my_plants;

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
                     child:IconButton(
                       icon: Icon(Icons.add,
                       size: 20,
                           color: Colors.green,),
                       onPressed: ()=>{} //addPlantToUserList(),
                     ),
                  ),
//when tapping the plants name
                  onTap: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => OpenContainer(
                                //TODO check if i need openbuilder
                                closedBuilder:
                                    (context, VoidCallback openContainer) =>
                                        PlantsDetails(
                                  plant: plants[i],
                                ),
                              )),
                    );
                  },
                ));
      },
    );
  }

  //  void addPlantToUserList() {
  //    //my_plants.DataBase.
  //
  //    my_plants.add(plants.single);
  //    FirestoreDB.usersDB.doc('plants').update([my_plants.toString()]);
  //
  //
  //
  // }
}
