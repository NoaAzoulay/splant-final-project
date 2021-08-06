import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noa/common_widgets/carouselSlider.dart';
import 'package:noa/common_widgets/showAlertDialog.dart';
import 'package:noa/common_widgets/showExceptionAlertDialog.dart';
import 'package:noa/screens/plants/addPlantPage.dart';
import 'package:noa/services/Auth.dart';
import 'package:noa/services/DataBase.dart';
import 'package:provider/provider.dart';

import '../../models/plant.dart';

class UsersPlants extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('My Plants'),
        actions: [
          TextButton(
            onPressed: () => _confirmSignOut(context),
            child: Text('Logout'),
          )
        ],
      ),
      body: _buildContents(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddPlant.show(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }

  //show a list of the user plants
  Widget _buildContents(BuildContext context) {
    final database = Provider.of<DataBase>(context, listen: false);
    return StreamBuilder<List<Plant>>(
      stream: database.plantsStream(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          final plants = snapshot.data;
          final children = plants.map((plant)=> Text(plant.name)).toList();
         // final image = plants.map((plant)=> Text(plant.image)).toString();
          //the way the plants will be shown
          return ListView(children:children);
         // return ManuallyControlledSlider();
        }
        if (snapshot.hasError){
          return Center(child: Text('Some Error Occurred'),);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
