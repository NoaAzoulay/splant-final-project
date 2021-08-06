import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

//todo delete
class plantInfo {
  String name;
  double soilHumidity;
  double airHumidity;
  double temp;
  double sun;
  String image;

plantInfo({this.name, this.soilHumidity, this.airHumidity, this.sun, this.temp, this.image});


  List<plantInfo> plantDb = [
   // plantInfo(name:'Cucumber',soilHumidity : 80.0, airHumidity: 30.0,sun:4.0, temp: 30.0, image:'cucumber.jpg' ),
    //plantInfo(name:'Tomato',soilHumidity : 80.0, airHumidity: 30.0,sun:4.0, temp: 30.0, image: 'tomato.jpg'),
    //plantInfo(name:'Coriander',soilHumidity : 80.0, airHumidity: 30.0,sun:5.0, temp: 25.0, image: 'coriander.jpg'),
    //plantInfo(name:'Parsley',soilHumidity : 80.0, airHumidity: 30.0,sun:5.0, temp: 25.0, image: 'parsley.jpg'),
    //plantInfo(name:'Orchid',soilHumidity : 50.0, airHumidity: 25.0,sun:1.0, temp: 20.0, image: 'orchid.jpg'),
    //plantInfo(name:'Tulip',soilHumidity : 70.0, airHumidity: 20.0,sun:1.0, temp: 19.0, image: 'tulip.jpg'),
    //plantInfo(name:'Buttercup',soilHumidity : 70.0, airHumidity: 20.0,sun:1.0, temp: 19.0, image: 'buttercup.jpg'),
    //plantInfo(name:'Cactus',soilHumidity : 40.0, airHumidity: 20.0,sun:5.0, temp: 30.0, image: 'cactus.jpg'),
    //plantInfo(name:'Succulent',soilHumidity : 40.0, airHumidity: 20.0,sun:5.0, temp: 30.0, image: 'succulents.jpg'),
    //plantInfo(name:'Mint',soilHumidity : 80.0, airHumidity: 20.0,sun:4.0, temp: 30.0, image: 'mint.jpg'),
    //plantInfo(name:'Lemon verbena',soilHumidity : 80.0, airHumidity: 30.0,sun:4.0, temp: 30.0, image: 'lemon_verbena.jpg'),
    //plantInfo(name:'Dill',soilHumidity : 80.0, airHumidity: 30.0,sun:4.0, temp: 27.0, image: 'dill.jpg'),
    //plantInfo(name:'Rosemary',soilHumidity : 50.0, airHumidity: 30.0,sun:4.0, temp: 30.0, image: 'rosemary.jpg'),
    //plantInfo(name:'Sweet pepper',soilHumidity : 80.0, airHumidity: 30.0,sun:5.0, temp: 25.0, image: 'sweet_pepper.jpg'),
    //plantInfo(name:'Strawberry',soilHumidity : 70.0, airHumidity: 30.0,sun:5.0, temp: 25.0, image: 'strawberry.jpg'),
    //plantInfo(name:'Aloe vera',soilHumidity : 60.0, airHumidity: 30.0,sun:4.0, temp: 30.0, image: 'aloe_vera.jpg'),
    //plantInfo(name:'Sansevieria',soilHumidity : 40.0, airHumidity: 20.0,sun:2.0, temp: 20.0, image: 'sansevieria.jpg'),
    //plantInfo(name:'Peace lily',soilHumidity : 60.0, airHumidity: 20.0,sun:3.0, temp: 25.0, image: 'peace_lilly.jpg'),
    //plantInfo(name:'Philodendron',soilHumidity : 60.0, airHumidity: 20.0,sun:2.0, temp: 30.0, image: 'philodendron.jpg'),
    //plantInfo(name:'Calathea',soilHumidity : 55.0, airHumidity: 20.0,sun:3.0, temp: 22.0, image: 'calathea.jpg'),
    plantInfo(name:'Cissus',soilHumidity : 55.0, airHumidity: 30.0,sun:3.0, temp: 25.0, image: 'cissus.jpg'),

  ];
  Map<String,dynamic> get map {
    return {
      "name": name,
      "soilHumidity": soilHumidity,
      "airHumidity":airHumidity,
      "sun": sun,
      "temp": temp,
      "image": image,

    };
  }
String get plantName{
    return name;
}

}