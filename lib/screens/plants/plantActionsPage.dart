import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noa/common_widgets/custom_elevated_button.dart';
import 'package:noa/models/plant.dart';
import 'package:noa/screens/plants/plantsDetailsCard.dart';
import 'package:noa/services/myClient.dart';

class PlantActionsPage extends StatelessWidget {
  final Plant plant;
  MyClient client = MyClient.instance;
  PlantActionsPage({this.plant});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                            decoration: decoration(),
                            width: 170,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 50,
                                  width: 150,
                                  decoration: decoration(),
                                  child: TextButton(
                                    onPressed: () =>
                                        client.activateSprayerManually(),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(FontAwesomeIcons.sprayCan),
                                        Text('Sprayer ON'),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 150,
                                  decoration: decoration(),
                                  child: TextButton(
                                    onPressed: () =>
                                        client.turnOffSprayerManually(),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(FontAwesomeIcons.stopCircle),
                                        Text('Sprayer OFF'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //buttons
                          ),
                          Container(
                            decoration: decoration(),
                            width: 170,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 50,
                                  width: 150,
                                  decoration: decoration(),
                                  child: TextButton(
                                    onPressed: () =>
                                        client.activateDripping(),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(FontAwesomeIcons.fillDrip),
                                        Text('Dripping ON'),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 150,
                                  decoration: decoration(),
                                  child: TextButton(
                                    onPressed: () =>
                                        client.turnOffDripping(),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(FontAwesomeIcons.stopCircle),
                                        Text('Dripping OFF'),
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

  BoxDecoration decoration() => BoxDecoration(
      border: Border.all(color: Colors.green[600], width: 2),
      borderRadius: BorderRadius.circular(10));

  // BoxDecoration buttonDecorationOn() => BoxDecoration(
  //     border: Border.all(color: Colors.green[600], width: 2),
  //     borderRadius: BorderRadius.circular(10));

  TextStyle tooltipTextStyle() =>
      TextStyle(fontFamily: 'IndieFlower', fontSize: 20, color: Colors.white);
}
