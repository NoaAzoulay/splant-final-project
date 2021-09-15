import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noa/common_widgets/showAlertDialog.dart';
import 'package:noa/common_widgets/showExceptionAlertDialog.dart';
import 'package:noa/models/plant.dart';
import 'package:noa/services/DataBase.dart';
import 'package:provider/provider.dart';

class AddMyOwnPlant extends StatefulWidget {
  final DataBase dataBase;
  const AddMyOwnPlant({Key key, this.dataBase}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    final dataBase = Provider.of<DataBase>(context, listen: false);
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddMyOwnPlant(
              dataBase: dataBase,
            ),
        fullscreenDialog: true));
  }

  @override
  _AddMyOwnPlantState createState() => _AddMyOwnPlantState();
}

class _AddMyOwnPlantState extends State<AddMyOwnPlant> {
  final _formKey = GlobalKey<FormState>();
  String name;
  double soilHum;
  double airHum;
  double uv;
  double tmp;

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
          final myPlant = Plant(
              name: name,
              soilHumidity: soilHum,
              airHumidity: airHum,
              uv: uv,
              tmp: tmp);
          await widget.dataBase.addNewPlant(myPlant);
          Navigator.of(context).pop();
        }
      } on FirebaseException catch (e) {
        showExceptionAlertDialog(context,
            title: 'An Error occurred, please try again', exception: e);
      }
    }
    //TODO validate and save form to firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.green,
        title: Text('Add My Own Plant'),
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
        onSaved: (value) => name = value,
        validator: (val) => val.isNotEmpty ? null : 'Name can\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'soil humidity (%)'),
        keyboardType: TextInputType.number,
        onSaved: (value) => soilHum = int.tryParse(value).toDouble() ?? 0.0,
        validator: (val) =>
            val.isNotEmpty ? null : 'Soil humidity can\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'air humidity (%)'),
        keyboardType: TextInputType.number,
        onSaved: (value) => airHum = int.tryParse(value).toDouble() ?? 0.0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'uv \ sun (1-5)'),
        keyboardType: TextInputType.number,
        onSaved: (value) => uv = int.tryParse(value).toDouble() ?? 0.0,
        validator: (val) => val.isNotEmpty ? null : 'uv can\'t be empty',
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Temperature (C)'),
        keyboardType: TextInputType.number,
        onSaved: (value) => tmp = int.tryParse(value).toDouble() ?? 0.0,
        validator: (val) =>
            val.isNotEmpty ? null : 'temperature can\'t be empty',
      ),
    ];
  }
}
