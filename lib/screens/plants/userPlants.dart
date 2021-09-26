import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noa/common_widgets/showExceptionAlertDialog.dart';
import 'package:noa/screens/plants/addPlantPage.dart';
import 'package:noa/services/DataBase.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../../models/plant.dart';

class UsersPlants extends StatefulWidget {
  @override
  _UsersPlantsState createState() => _UsersPlantsState();
}

class _UsersPlantsState extends State<UsersPlants> {
  final width = window.physicalSize.width;

  final height = window.physicalSize.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContents(context),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => AddPlant.show(context),
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<DataBase>(context, listen: false);
    return StreamBuilder<List<Plant>>(
      stream: database.plantsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Some Error Occurred'),
          );
        }
        if(snapshot.hasData) {
          final plants = snapshot.data;
          //the way plants will be shown
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2/1,
              mainAxisSpacing: 15,
            ),
            itemCount: plants.length,
            itemBuilder: (context, i) => SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.brown[200], width: 2),
                  color: Colors.white,
                  ),
                  child: Dismissible(
                    background: Container(color: Colors.grey,
                    child: Icon(Icons.delete_outline,
                      size: 40,
                    ),),
                    direction: DismissDirection.endToStart,
                    key: Key('plant-${plants[i].id}'),
                    onDismissed: (direction)=>_delete(context, plants[i]) ,
                    child: GridTile(
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                      //padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.brown[200], width: 3),
                                  image: DecorationImage(
                                      image: NetworkImage(plants[i].image),
                                      fit: BoxFit.cover,
                                  ),
                      ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 150),
                                    child: Text(
                                        plants[i].name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'IndieFlower',
                                          color: Colors.brown[50],
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2,
                                         decorationStyle: TextDecorationStyle.wavy,
                                         // backgroundColor: Colors.white60
                                        ),
                                      ),
                                  ),
                                ),
                                ),
                                //Todo sensors data
                                   Padding(
                                    padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white60,
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(height: 2,),
                                          Tooltip(
                                            message: 'soil humidity',
                                            textStyle: tooltipTextStyle(),
                                            child: CircleAvatar(
                                              child: Icon(FontAwesomeIcons.fillDrip,
                                                      size: 20,
                                                      color: Colors.black87,),
                                            ),
                                          ),
                                              Text(
                                                plants[i].soilHumidity.toString()+' %',
                                                style: textStyle(),
                                              ),
                                          SizedBox(height: 2,),
                                          Tooltip(message: 'sun / uv in range 1-5',
                                            textStyle: tooltipTextStyle(),
                                            child:
                                            CircleAvatar(
                                              backgroundColor: Colors.yellowAccent[100],
                                              child: Icon(FontAwesomeIcons.sun,
                                                size: 23,
                                                color: Colors.black87,),
                                            ),
                                          ),
                                          Text(plants[i].uv.toString(),
                                              style: textStyle(),),
                                          SizedBox(height: 2,),
                                          Tooltip(message: 'temperature',
                                            textStyle: tooltipTextStyle(),
                                            child:
                                            CircleAvatar(
                                              backgroundColor: Colors.orangeAccent[100],
                                              child: Icon(FontAwesomeIcons.thermometerEmpty,
                                                size: 23,
                                                color: Colors.black87,),
                                            ),
                                          ),
                                          Text(plants[i].tmp.toString()+' C',
                                              style: textStyle()),
                                        ],
                                      ),
                                    ),
                                  ),
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  child: IconButton(
                                      onPressed: (){},
                                      icon: Icon(Icons.double_arrow)),
                                ),
                              ],
                          ),
                        ),
                      ),
                  ),
                        ),
              ),
                    )
              );

        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  TextStyle tooltipTextStyle()=>TextStyle(fontFamily: 'IndieFlower', fontSize: 20, color: Colors.white);

  TextStyle textStyle()=>TextStyle(fontSize: 17,fontFamily:'IndieFlower',fontWeight: FontWeight.bold);

 Future<void> _delete(BuildContext context, Plant plant) async {
   try {
     final database = Provider.of<DataBase>(context, listen: false);
     await database.deletePlant(plant);
   }on FirebaseException catch(e){
     showExceptionAlertDialog(
         context,
     title: 'Operation Failed',
     exception: e);
   }
  }
}
