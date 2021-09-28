import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:noa/services/jsonHandler.dart';

class ServerDataJson {
  final String temperature;
  final String soilHumidity1;
  final String soilHumidity2;
  final String soilHumidity3;
  final String soilHumidity4;
  final String airHumidity;
  final String uv;
  final String intensity;

  ServerDataJson({
    this.temperature,
    this.soilHumidity1,
    this.soilHumidity2,
    this.soilHumidity3,
    this.soilHumidity4,
    this.airHumidity,
  this.uv,
  this.intensity});


  factory ServerDataJson.fromJson(Map<String, dynamic> json) {
    return ServerDataJson(
      soilHumidity1: json["Soil_Humidity1"] ,
      soilHumidity2: json["Soil_Humidity2"],
      soilHumidity3: json["Soil_Humidity3"],
      soilHumidity4: json["Soil_Humidity4"],
      temperature: json["MY_TEMPERATURE"],
      airHumidity: json["MY_HUMIDITY"],
      intensity: json["SOLAR_INTENSITY"],
      uv: json["UVindex"],
    );
  }

  // A function that converts a response body into a List<ServerDataJson>.
  void parseData(String responseBody) {
    Map<String, dynamic> parsed = jsonDecode(responseBody);
    var JD = ServerDataJson.fromJson(parsed);
    JsonHandler.instance.setData(JD);
  }

}
