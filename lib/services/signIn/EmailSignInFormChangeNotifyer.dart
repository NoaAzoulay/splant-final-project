import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noa/common_widgets/FormedSubmitButton.dart';
import 'package:noa/common_widgets/showExceptionAlertDialog.dart';
import 'package:noa/services/Auth.dart';
import 'package:provider/provider.dart';
import 'EmailSignInChangeModel.dart';

class EmailSignInFormChangeNotifyer extends StatefulWidget {
  final EmailSignInChangeModel model;

  EmailSignInFormChangeNotifyer({this.model});

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      create: (_) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
        //called when notify listeners is called
        builder: (_, model, __) => EmailSignInFormChangeNotifyer(model: model),
      ),
    );
  }

  @override
  _EmailSignInFormChangeNotifyerState createState() =>
      _EmailSignInFormChangeNotifyerState();
}

class _EmailSignInFormChangeNotifyerState extends State<EmailSignInFormChangeNotifyer> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _paswwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  EmailSignInChangeModel get model =>widget.model;

  @override
//remove Email from widget tree
  void dispose() {
    _emailController.dispose();
    _paswwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await widget.model.submit();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: 'Sign in Failed',
        exception: e,
      );
    }
  }

  void _emailEditingComplete() {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

//reset form
  void _toggleFormType() {
    model.toggleFormType();
    //control the text fields
    _emailController.clear();
    _paswwordController.clear();
  }

  List<Widget> _buildChildren() {
    return [
      _buildEmailTextField(),
      SizedBox(height: 10.0),
      _buildPasswordTextField(),
      SizedBox(height: 10.0),
      FormSubmitButton(
        text: model.primaryButtonText,
        onPressed: model.canSubmit ? _submit : null,
      ),
      SizedBox(height: 10.0),
      TextButton(
        child: Text(
          model.secondaryButtonText,
          style: TextStyle(
            color: Colors.green,
            fontSize: 15.0,
          ),
        ),
        onPressed: !model.isLoading ? _toggleFormType : null,
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    return TextField(
      controller: _paswwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
        labelStyle: TextStyle(
          color: Colors.green,
          fontSize: 20.0,
        ),
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: model.updatePassword,
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'example@example.com',
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
        labelStyle: TextStyle(
          color: Colors.green,
          fontSize: 20.0,
        ),
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _emailEditingComplete(),
      onChanged: model.updateEmail,
    );
  }

  @override
  Widget build(BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(),
            ),
          );
  }
}
