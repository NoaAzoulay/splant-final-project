import 'package:flutter/material.dart';


import 'EmailSignInFormChangeNotifyer.dart';


class EmailSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sign in'),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
              child: EmailSignInFormChangeNotifyer.create(context),
          ),
        ),
      ),
      backgroundColor: Colors.green[100],
    );
  }

}
