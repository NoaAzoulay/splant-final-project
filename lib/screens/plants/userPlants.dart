import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noa/common_widgets/carouselSlider.dart';
import 'package:noa/common_widgets/showAlertDialog.dart';
import 'package:noa/common_widgets/showExceptionAlertDialog.dart';
import 'package:noa/screens/plants/addPlantPage.dart';
import 'package:noa/screens/plants/plantListTile.dart';
import 'package:noa/screens/plants/plantsDetailsCard.dart';
import 'package:noa/services/Auth.dart';
import 'package:noa/services/DataBase.dart';
import 'package:provider/provider.dart';

import '../../models/plant.dart';
import 'addEditMyOwnPlant.dart';

class UsersPlants extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Plants'),
        // actions: [
        //   //TODO move from here
        //   TextButton(
        //     onPressed: () => _confirmSignOut(context),
        //     child: Text('Logout'),
        //   )
        // ],
      ),
      body: _buildContents(context),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => AddPlant.show(context),
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
          ),
          SizedBox(
            height: 20,
          ),
          //custom add plant
          Tooltip(
            message: 'Add your own plant',
            child: FloatingActionButton(
              //TODO
              onPressed: () => AddEditMyOwnPlant.show(context), //AddPlant.show(context),
              child: Icon(Icons.post_add_rounded),
              backgroundColor: Colors.green[700],
              heroTag: true,
            ),
          ),
        ],
      ),
    );
  }


  //show the list of the user's plants
  Widget _buildContents(BuildContext context) {
    final database = Provider.of<DataBase>(context, listen: false);
    return StreamBuilder<List<Plant>>(
      stream: database.plantsStream(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          final plants = snapshot.data;
          final children = plants.map((plant)=>
              PlantListTile(plant: plant,
                onTap: ()=>
                   // PlantsDetails(plant: plant)),)
          AddEditMyOwnPlant.show(context, plant: plant),))
              .toList();
          //final List<Text> imageList = plants.map((plant)=> Text(plant.image)).toList();
          //the way the plants will be shown
         return ListView(children:children);
         //return ManuallyControlledSlider();
        }
        if(!snapshot.hasData){
          return Center(child: Text('it\'s empty here!\nadd new plants'));
        }
       if (snapshot.hasError){
          return Center(child: Text('Some Error Occurred'),);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
