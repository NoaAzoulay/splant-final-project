import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noa/models/plant.dart';
import 'package:noa/screens/plants/plantsDetailsCard.dart';
import 'package:noa/services/jsonHandler.dart';
import 'package:noa/services/myClient.dart';

class PlantActionsPage extends StatelessWidget {
  final Plant plant;
  MyClient client = MyClient.instance;
  JsonHandler jsonHandler = JsonHandler.instance;
  PlantActionsPage({this.plant});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 900,
                  height: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.brown[200], width: 3),
                    image: DecorationImage(
                      image: NetworkImage(plant.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 210),
                    child: Text(
                      plant.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'IndieFlower',
                        color: Colors.brown[50],
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        decorationStyle: TextDecorationStyle.wavy,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 12, 0, 5),
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Plant\'s Growing Conditions',
                              style: textStyle(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            decoration: decoration(),
                            child: Padding(
                              padding: EdgeInsets.only(top: 7),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  PlantsDetails().soilHumidityIcon(plant),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  PlantsDetails().tempIcon(plant),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  PlantsDetails().uvIcon(plant)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //todo sensors data
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 12, 0, 5),
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Current Plant Data',
                          style: textStyle(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 28, right: 28),
                      child: Container(
                        decoration: decoration(),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              soilHumidityIcon(plant),
                              SizedBox(
                                width: 20,
                              ),
                              tempIcon(plant),
                              SizedBox(
                                width: 20,
                              ),
                              uvIcon(plant),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(45, 20, 45, 5),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    decoration: decoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 3, right: 15),
                          child: Icon(FontAwesomeIcons.infoCircle, size: 30, color: Colors.greenAccent[400],),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 3.0, bottom: 4, top: 4),
                          child: Text(
                            'Automatic Dripping starts\nwhen soil humidity is: '+plant.threshold.toString()+' %',
                            style: IcontextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 12, 0, 5),
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Actions',
                          style: textStyle(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            width: 190,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 50,
                                  width: 170,
                                  decoration: decoration(),
                                  child: TextButton(
                                    onPressed: () =>
                                        client.activateSprayerManually(),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(FontAwesomeIcons.sprayCan, color: Colors.blue[800],),
                                        Text('Sprayer ON',
                                        style: IcontextStyle(),),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 170,
                                  decoration: decoration(),
                                  child: TextButton(
                                    onPressed: () =>
                                        client.turnOffSprayerManually(),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(FontAwesomeIcons.stopCircle, color: Colors.blueGrey,),
                                        Text('Sprayer OFF',
                                          style: IcontextStyle(),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //buttons
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            width: 190,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 50,
                                  width: 170,
                                  decoration: decoration(),
                                  child: TextButton(
                                    onPressed: () =>
                                        client.activateDripping(),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(FontAwesomeIcons.fillDrip, color: Colors.blue[800],),
                                        Text('Dripping ON',
                                          style: IcontextStyle(),),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 170,
                                  decoration: decoration(),
                                  child: TextButton(
                                    onPressed: () =>
                                        client.turnOffDripping(),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(FontAwesomeIcons.stopCircle, color: Colors.blueGrey,),
                                        Text('Dripping OFF',
                                        style: IcontextStyle(),),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //buttons
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle textStyle() => TextStyle(
      fontFamily: 'IndieFlower',
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.green[900]);

  TextStyle IcontextStyle()=>  TextStyle(
      fontFamily: 'IndieFlower',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.green);

  BoxDecoration decoration() => BoxDecoration(
      border: Border.all(color: Colors.green[600], width: 2),
      borderRadius: BorderRadius.circular(10));


  TextStyle tooltipTextStyle() =>
      TextStyle(fontFamily: 'IndieFlower', fontSize: 20, color: Colors.white);


  Widget soilHumidityIcon(Plant plant) => Column(
    verticalDirection: VerticalDirection.down,
    children: [
      SizedBox(
        width: 50,
        height: 50,
        child:
        Tooltip(
          message: 'soil humidity',
          textStyle: tooltipTextStyle(),
          child: CircleAvatar(
            child: Icon(FontAwesomeIcons.fillDrip,
              size: 20,
              color: Colors.black87,),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      checkBoxNumberToSetSoilHumidity(plant.serial)
    ],
  );

  Widget tempIcon(plant) => Column(
    verticalDirection: VerticalDirection.down,
    children: [
      SizedBox(
        width: 50,
        height: 50,
        child: Tooltip(message: 'temperature',
          textStyle: tooltipTextStyle(),
          child:
          CircleAvatar(
            backgroundColor: Colors.orangeAccent[100],
            child: Icon(FontAwesomeIcons.thermometerEmpty,
              size: 23,
              color: Colors.black87,),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        jsonHandler.dataServer.temperature+' C',
        style: IcontextStyle(),
      ),
    ],
  );

  Widget uvIcon(plant) => Column(
    verticalDirection: VerticalDirection.down,
    children: [
      SizedBox(
        width: 50,
        height: 50,
        child: Tooltip(message: 'sun / uv in range 0-1',
          textStyle: tooltipTextStyle(),
          child:
          CircleAvatar(
            backgroundColor: Colors.yellowAccent[100],
            child: Icon(FontAwesomeIcons.sun,
              size: 23,
              color: Colors.black87,),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        (jsonHandler.dataServer.uv).toString(),
        style: IcontextStyle(),
      ),
    ],
  );

  Text checkBoxNumberToSetSoilHumidity(String serial){
    switch(serial){
      case "1":
        return Text(
          jsonHandler.dataServer.soilHumidity1+' %',
          style: IcontextStyle(),
        );
        break;
      case "2":
        return Text(
          jsonHandler.dataServer.soilHumidity2+' %',
          style: IcontextStyle(),
        );
        break;
      case "3":
        return Text(
          jsonHandler.dataServer.soilHumidity3+' %',
          style: IcontextStyle(),
        );
      case "4":
        return Text(
          jsonHandler.dataServer.soilHumidity4+' %',
          style: IcontextStyle(),
        );
    }

  }
}
