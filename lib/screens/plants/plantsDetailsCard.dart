import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noa/models/plant.dart';

//TODO add information about plants
class PlantsDetails extends StatelessWidget {
  final Plant plant;
  PlantsDetails({this.plant});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        color: Colors.white38,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: Colors.green, width: 2)),
            child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //x button
                      Container(
                        height: 33,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.close),
                          alignment: Alignment.center,
                          onPressed: Navigator.of(context).pop,
                          iconSize: 15,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildImage(),
                      SizedBox(
                        height: 20,
                      ),
                      buildText(context),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          soilHumidityIcon(),
                          SizedBox(
                            width: 20,
                          ),
                          tempIcon(),
                          SizedBox(
                            width: 20,
                          ),
                          uvIcon()
                        ],
                      )
                    ],
                  ),
                )
                //Text(plant.name),
                ),

    ),
        ),
      );
  }

  Widget buildImage() => Image.network(
        plant.image,
        fit: BoxFit.cover,
        height: 300,
      );

  Widget buildText(BuildContext context) => Text(
        plant.name,
        style: TextStyle(
          fontFamily: 'IndieFlower',
          fontSize: 40,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          color: Colors.green,
        ),
      );


  Widget soilHumidityIcon() => Column(
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
              Text(
                plant.soilHumidity.toString()+' %',
                style: textStyle(),
              ),
        ],
      );

  Widget tempIcon() => Column(
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
                plant.tmp.toString()+' C',
                style: textStyle(),
              ),
        ],
      );

  Widget uvIcon() => Column(
        verticalDirection: VerticalDirection.down,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Tooltip(message: 'sun / uv in range 1-5',
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
            plant.uv.toString(),
            style: textStyle(),
          ),
        ],
      );

  TextStyle textStyle()=>  TextStyle(
      fontFamily: 'IndieFlower',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.green);
  TextStyle tooltipTextStyle()=>TextStyle(fontFamily: 'IndieFlower', fontSize: 20, color: Colors.white);

}
