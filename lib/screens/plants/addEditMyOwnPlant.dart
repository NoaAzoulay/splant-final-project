import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noa/common_widgets/showAlertDialog.dart';
import 'package:noa/common_widgets/showExceptionAlertDialog.dart';
import 'package:noa/models/plant.dart';
import 'package:noa/screens/plants/plantsDetailsCard.dart';
import 'package:noa/services/DataBase.dart';
import 'package:provider/provider.dart';

class AddEditMyOwnPlant extends StatefulWidget {
  final DataBase dataBase;
  final Plant plant;
  const AddEditMyOwnPlant({Key key, this.dataBase, this.plant}) : super(key: key);

  static Future<void> show(BuildContext context, {Plant plant}) async {
    final dataBase = Provider.of<DataBase>(context, listen: false);
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => //PlantsDetails(plant: plant,),
            AddEditMyOwnPlant(
              dataBase: dataBase,
          plant: plant,
            ),
        fullscreenDialog: true));
  }

  @override
  _AddEditMyOwnPlantState createState() => _AddEditMyOwnPlantState();
}

class _AddEditMyOwnPlantState extends State<AddEditMyOwnPlant> {
  final _formKey = GlobalKey<FormState>();
  String name;
  int soilHum;
  int airHum;
  int uv;
  int tmp;

  @override
  void initState(){
    super.initState();
    if(widget.plant!= null){
      name = widget.plant.name;
      soilHum= widget.plant.soilHumidity;
      airHum= widget.plant.airHumidity;
      uv= widget.plant.uv;
      tmp= widget.plant.tmp;
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        final plants = await widget.dataBase.plantsStream().first;
        final allNames = plants.map((plant) => plant.name).toList();
        if (allNames.contains(name)) {
          showAlertDialog(context,
              title: 'Name already used',
              content: 'Please choose a different plant name',
              defaultActionText: 'OK');
        } else {
          final id = widget.plant?.id ?? docIdFromCurrentDate();
          final myPlant = Plant(
              name: name,
              soilHumidity: soilHum,
              airHumidity: airHum,
              uv: uv,
              tmp: tmp,
              id: id);
          await widget.dataBase.addNewCustomPlant(myPlant);
          Navigator.of(context).pop();
        }
      } on FirebaseException catch (e) {
        showExceptionAlertDialog(context,
            title: 'An Error occurred, please try again', exception: e);
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.green,
        title: Text(widget.plant == null ? 'Add My Own Plant': 'Edit Plant\'s details'),
        actions: <Widget>[
          TextButton(
            onPressed: () => _submit(),
            child: Text(
              'save',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
      body: _buildContent(),
      backgroundColor: Colors.green[200],
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'name \ nickname'),
        initialValue: name,
        onSaved: (value) => name = value,
        validator: (val) => val.isNotEmpty ? null : 'Name can\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'soil humidity (%)'),
        initialValue: '$soilHum',
        keyboardType: TextInputType.number,
        onSaved: (value) => soilHum = int.tryParse(value),
        validator: (val) =>
            val.isNotEmpty ? null : 'Soil humidity can\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'air humidity (%)'),
        initialValue: '$airHum',
        keyboardType: TextInputType.number,
        onSaved: (value) => airHum = int.tryParse(value),
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'uv \ sun (1-5)'),
        initialValue: '$uv',
        keyboardType: TextInputType.number,
        onSaved: (value) => uv = int.tryParse(value) ,
        validator: (val) => val.isNotEmpty ? null : 'uv can\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Temperature (C)'),
        initialValue: '$tmp',
        keyboardType: TextInputType.number,
        onSaved: (value) => tmp = int.tryParse(value),
        validator: (val) =>
            val.isNotEmpty ? null : 'temperature can\'t be empty',
      ),
    ];
  }
}
