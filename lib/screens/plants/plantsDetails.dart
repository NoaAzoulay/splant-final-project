import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noa/models/plant.dart';

//TODO add information about plants , add links to images in firestore, add closing to cards
class PlantsDetails extends StatelessWidget {
  final Plant plant;
  PlantsDetails({this.plant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.green, width: 2)),
        child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  buildImage(),
                  SizedBox(
                    height: 15,
                  ),
                  buildText(context),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      airHumidityIcon(),
                      SizedBox(
                        width: 15,
                      ),
                      soilHumidityIcon(),
                      SizedBox(
                        width: 15,
                      ),
                      tempIcon(),
                      SizedBox(
                        width: 15,
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

  Widget airHumidityIcon() => Column(
        verticalDirection: VerticalDirection.down,
        children: [
          SizedBox(
            width: 50,
            height: 45,
            child: Tooltip(
              message: 'Air humidity',
              child: Image.asset(
                ('assets/icons/air_hum.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                plant.airHumidity.toInt().toString(),
                style: TextStyle(
                    fontFamily: 'IndieFlower',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green
                ),
              ),
              Text('%'),
            ],
          )
        ],
      );

  Widget soilHumidityIcon() => Column(
        verticalDirection: VerticalDirection.down,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Tooltip(
              message: 'soil humidity',
              child: Image.asset(
                ('assets/icons/soil_hum.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                plant.soilHumidity.toInt().toString(),
                style: TextStyle(
                    fontFamily: 'IndieFlower',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green
                ),
              ),
              Text('%'),
            ],
          )
        ],
      );

  Widget tempIcon() => Column(
        verticalDirection: VerticalDirection.down,
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Tooltip(
              message: 'Temperature',
              child: Image.asset(
                ('assets/icons/temp.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                plant.tmp.toInt().toString(),
                style: TextStyle(
                  fontFamily: 'IndieFlower',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green
                ),
              ),
              Text('   ')
            ],
          ),
        ],
      );

  Widget uvIcon() => Column(
        verticalDirection: VerticalDirection.down,
        children: [
           SizedBox(
              width: 50,
              height: 50,
              child: Tooltip(
                message: 'uv in range 1-5',
                child: Image.asset(
                  ('assets/icons/uv.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),

          SizedBox(
            height: 10,
          ),
          Text(
            plant.uv.toInt().toString(),
            style: TextStyle(
                fontFamily: 'IndieFlower',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green
            ),
          ),
        ],
      );
}
