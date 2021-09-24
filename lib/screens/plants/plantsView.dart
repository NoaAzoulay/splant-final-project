
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noa/models/plant.dart';
import 'package:noa/services/DataBase.dart';

class PlantsView extends StatelessWidget {
  final Plant plant;
  final VoidCallback onTap;
  final int length;


  const PlantsView({Key key, this.plant, this.onTap, this.length})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 50,
        child: Column(
          children: [
            Image.network(plant.image),
            Text(plant.name),
          ],
        ),

      ),
    );
  }
    // Widget buildGridView() =>
    //     GridView.builder(
    //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //           crossAxisCount: 1,
    //         ),
    //         itemCount: length,
    //         itemBuilder: (context, index) => buildPlantCard(index));
    //
    // Widget buildPlantCard(int index) {
    //   return GridTile(
    //     header: Text(plant.name),
    //       child: Container(height:20, width: 20,child: Image.network(plant.image)),
    //   footer: Text(plant.airHumidity.toString()),);
    //
    // }


    // return Column(
    //   children:[
    //     SingleChildScrollView(
    //       child: Container(
    //         alignment: Alignment.center,
    //          // height: 100,
    //          // width: 100,
    //          child: Row(
    //            mainAxisAlignment: MainAxisAlignment.center,
    //            children: [
    //              Column(children: [
    //          Padding(
    //            padding: const EdgeInsets.all(8.0),
    //            child: Container(child: Image.network(plant.image),
    //            height: 200,
    //            width: 200,),
    //          ),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Text(plant.name),
    //         ),
    //              ],)
    //            ],
    //          ),
    //        ),
    //       ),],
    //       );

    //   leading: Card(child: Image.network(plant.image),),
    //   title: Text(plant.name),
    //   onTap: onTap,
    // //  leading: CircleAvatar(child: Image.network(plant.image)),
    //   trailing: Icon(Icons.chevron_right),
    //   )
    // ;
  }




