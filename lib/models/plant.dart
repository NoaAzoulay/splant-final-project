//option to add a plant which doesnt exist in DB
class Plant {
  final String name;
  final double soilHumidity;
  final double airHumidity;
  final double uv;
  final double tmp;
  final String image;

  Plant(
      {this.name,
      this.soilHumidity,
      this.airHumidity,
      this.uv,
      this.tmp,
      this.image});

  //return data only if there are data (dont rebuild if not)
  factory Plant.fromMap(Map<String, dynamic> data){
    if (data==null){
      return null;
    }
    final String name = data['name'];
    final double airHumidity = data['Air Humidity'];
    final double soilHumidity = data['Soil Humidity'];
    final double uv = data['UV'];
    final double tmp = data['Temperature'];
    final String image = data['image'];
    return Plant(
      name: name,
      airHumidity: airHumidity,
      soilHumidity: soilHumidity,
      uv: uv,
      tmp: tmp,
      image: image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'soilHumidity': soilHumidity,
      'airHumidity': airHumidity,
      'UV': uv,
      'temperature': tmp,
      'image': image,
    };
  }
}
