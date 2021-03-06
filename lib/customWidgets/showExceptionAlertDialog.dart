import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:noa/customWidgets/showAlertDialog.dart';

Future<void> showExceptionAlertDialog(
  BuildContext context,{
    String title,
Exception exception,
}) => showAlertDialog(
  context,
  title: title,
  content: _message(exception),
  defaultActionText: 'OK'
);

String _message(Exception exception){
  if(exception is FirebaseException){
    return exception.message;
  }
  return exception.toString();
}