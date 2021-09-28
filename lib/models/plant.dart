class Plant {
  final String name;
  final int soilHumidity;
  final int airHumidity;
  final int uv;
  final int tmp;
  final String image;
  final String id;
  final String serial;
  final int threshold;

  Plant(
      {this.name,
      this.soilHumidity,
      this.airHumidity,
      this.uv,
      this.tmp,
      this.image,
      this.id,
      this.serial,
      this.threshold: 0});

  //return data only if there are data (dont rebuild if not)
  factory Plant.fromMap(Map<String, dynamic> data, String docID) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final int airHumidity = (data['Air Humidity'] as int);
    final int soilHumidity = (data['Soil Humidity'] as int);
    final int uv = (data['UV'] as int);
    final int tmp = (data['Temperature'] as int);
    final String image = data['image'];
    final String serial = data['serial'];
    final int threshold = data['threshold'] as int;

    return Plant(
        name: name,
        airHumidity: airHumidity,
        soilHumidity: soilHumidity,
        uv: uv,
        tmp: tmp,
        image: image,
        id: docID,
        serial: serial,
        threshold: threshold);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'soilHumidity': soilHumidity,
      'airHumidity': airHumidity,
      'uv': uv,
      'temperature': tmp,
      'image': image,
      'serial': serial,
      'threshold':threshold,
    };
  }
}
