import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noa/models/plant.dart';

class PlantListTile extends StatelessWidget {
  final Plant plant;
  final VoidCallback onTap;

  const PlantListTile({Key key, this.plant, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(plant.name),
      onTap: onTap,
    //  leading: CircleAvatar(child: Image.network(plant.image)),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
