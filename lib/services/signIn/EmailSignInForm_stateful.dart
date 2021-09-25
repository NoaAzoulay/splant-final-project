import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noa/common_widgets/FormedSubmitButton.dart';
import 'package:noa/common_widgets/showExceptionAlertDialog.dart';
import 'package:noa/services/Auth.dart';
import 'package:noa/services/signIn/validators.dart';
import 'package:provider/provider.dart';
import 'EmailSignInModel.dart';



class EmailSignInFormStateful extends StatefulWidget with EmailAndPasswordsValidators {

  @override
  _EmailSignInFormStatefulState createState() => _EmailSignInFormStatefulState();
}

class _EmailSignInFormStatefulState extends State<EmailSignInFormStateful> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _paswwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  String get _email => _emailController.text;
  String get _password => _paswwordController.text;
  EmailSignInFormType _formType = EmailSignInFormType.signIn;
  bool _submitted = false;
  bool _isLoading = false;

@override
//remove Email from widget tree
  void dispose(){
  _emailController.dispose();
  _paswwordController.dispose();
  _emailFocusNode.dispose();
  _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _submitted=true;
      _isLoading=true;});
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.CreateUserWithEmailAndPassword(_email, _password);
      }
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
          context,
      title: 'Sign in Failed',
      exception: e,
      );
    } finally{
      setState(() {
        _isLoading=false;
      });
    }
  }

  void _emailEditingComplete(){
    final newFocus=widget.emailValidator.isValid(_email)?
    _passwordFocusNode: _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    setState(() {
      _submitted=false;
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });
    _emailController.clear();
    _paswwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign In'
        : 'Create an Account';
    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an Account? Register'
        : 'Have an Account? Sign In';

    bool submitEnabled = widget.emailValidator.isValid(_email)&&
        widget.passwordValidator.isValid(_password)&&!_isLoading;


    return [
      _buildEmailTextField(),
      SizedBox(height: 10.0),
      _buildPasswordTextField(),
      SizedBox(height: 10.0),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled? _submit: null,
      ),
      SizedBox(height: 10.0),
      TextButton(
        child: Text(
          secondaryText,
          style: TextStyle(
            color: Colors.green,
            fontSize: 15.0,
          ),
        ),
        onPressed:!_isLoading? _toggleFormType:null,
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =_submitted&& !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _paswwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText? widget.invalidPasswordErrorText: null,
        enabled: _isLoading==false,
        labelStyle: TextStyle(
          color: Colors.green,
          fontSize: 20.0,
        ),
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: (password)=> _updateState(),
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted&& !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'example@example.com',
        errorText: showErrorText?widget.invalidEmailErrorText: null,
        enabled: _isLoading==false,
        labelStyle: TextStyle(
          color: Colors.green,
          fontSize: 20.0,
        ),
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
      onChanged: (email) => _updateState(),
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
  void _updateState(){
    setState(() {});
  }
}
