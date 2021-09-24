import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noa/screens/plants/addPlantPage.dart';
import 'package:noa/screens/plants/plantsDetailsCard.dart';
import 'package:noa/services/DataBase.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import '../../models/plant.dart';

class UsersPlants extends StatelessWidget {
  final width = window.physicalSize.width;
  final height = window.physicalSize.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Splant.',
          style: TextStyle(
              color: Colors.white, fontFamily: 'IndieFlower', fontSize: 30),
        ),
        // centerTitle: true,
        backgroundColor: Colors.green,
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
        ],
      ),
    );
  }

//show the list of the users plants
  Widget _buildContents(BuildContext context) {
    final database = Provider.of<DataBase>(context, listen: false);
    return StreamBuilder<List<Plant>>(
      stream: database.plantsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final plants = snapshot.data;
          //the way the plants will be shown
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2/1,
              //mainAxisSpacing: 15,
            ),
            itemCount: plants.length,
            itemBuilder: (context, i) => SafeArea(
              child: Container(
                color: Colors.white,
                child: GridTile(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                      child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 3),
                        image: DecorationImage(
                            image: NetworkImage(plants[i].image),
                            fit: BoxFit.cover)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Todo sensors data
                           Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                            child: Container(
                              //width: width,
                              //height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white60,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                         Icon(FontAwesomeIcons.fillDrip,
                                          size: 10,
                                          color: Colors.black87,),
                                      Text(
                                        plants[i].soilHumidity.toString(),
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: width / 80,
                                  ),
                                  Text(plants[i].airHumidity.toString(),
                                      style: TextStyle(fontSize: 10)),
                                  SizedBox(
                                    width: width / 80,
                                  ),
                                  Text(plants[i].uv.toString(),
                                      style: TextStyle(fontSize: 10)),
                                  SizedBox(
                                    width: width / 80,
                                  ),
                                  Text(plants[i].tmp.toString(),
                                      style: TextStyle(fontSize: 10))
                                ],
                              ),
                            ),
                          ),
                        Container(
                          color: Colors.white60,
                          width: width,
                          child: Text(
                            plants[i].name,
                            style: TextStyle(
                              fontFamily: 'IndieFlower',
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.double_arrow)),
                        ),
                      ],
                  ),
                ),
                    )),
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('Some Error Occurred'),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
