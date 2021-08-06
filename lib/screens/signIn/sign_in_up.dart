import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:noa/common_widgets/custom_elevated_button.dart';
import 'package:noa/common_widgets/showExceptionAlertDialog.dart';
import 'package:noa/screens/signIn/EmailSignIn.dart';
import 'package:noa/screens/signIn/SignInManager.dart';
import 'package:noa/services/Auth.dart';
import 'package:provider/provider.dart';

class signInUp extends StatelessWidget {
  final SignInManager manager;
  final bool isLoading;
  const signInUp({Key key, this.manager, this.isLoading}) : super(key: key);

  //create sign in page
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      //rebuild after notifies of changes
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          //to dispose widget when removed from tree
          child: Consumer<SignInManager>(
            builder: (_, manager, __) => signInUp(manager: manager, isLoading: isLoading.value,),
          ),
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(context,
        title: 'Sign in Failed', exception: exception);
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      );
    }
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await manager.signInAnonymously();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await manager.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignIn(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 80.0, child: _buildHeader()),
          Text(
            'Splant.',
            style: TextStyle(
                fontSize: 65.0,
                fontWeight: FontWeight.normal,
                letterSpacing: 3,
                color: Colors.green,
                fontFamily: 'IndieFlower'),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 60,
          ),
          customElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/logos/google-logo.png'),
                ),
                Text(
                  'Sign in with Google',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15.0,
                  ),
                ),
                Opacity(
                  opacity: 0.0,
                  child: Image(
                    image: AssetImage('assets/logos/google-logo.png'),
                  ),
                ),
              ],
            ),
            bgcolor: MaterialStateProperty.all<Color>(Colors.grey[200]),
            borderColor: Colors.grey[200],
            radius: 4.0,
            onPressed: isLoading ? null : () => _signInWithGoogle(context),
          ),
          SizedBox(
            height: 8,
          ),
          customElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //Image.asset('logos/facebook_logo.jpg'),
                Image(
                  image: AssetImage('assets/logos/facebook_logo.jpg'),
                ),
                Text(
                  'Sign in with Facebook',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
                Opacity(
                  opacity: 0.0,
                  child: Image(
                    image: AssetImage('assets/logos/facebook_logo.jpg'),
                  ),
                ),
              ],
            ),
            bgcolor: MaterialStateProperty.all<Color>(Colors.blue[900]),
            borderColor: Colors.blue[900],
            radius: 4.0,
            onPressed: isLoading ? null : () => _signInWithFacebook(context),
          ),
          SizedBox(
            height: 8,
          ),
          customElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //Image.asset('logos/facebook_logo.jpg'),
                Image(
                  image: AssetImage('assets/logos/email_logo.jpg'),
                ),
                Text(
                  'Sign in with Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
                Opacity(
                  opacity: 0.0,
                  child: Image(
                    image: AssetImage('assets/logos/email_logo.jpg'),
                  ),
                ),
              ],
            ),
            bgcolor: MaterialStateProperty.all<Color>(Colors.teal[600]),
            borderColor: Colors.teal[600],
            radius: 4.0,
            onPressed: isLoading ? null : () => _signInWithEmail(context),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'or',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8,
          ),
          customElevatedButton(
            child: Text(
              'Go Anonymous',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
            bgcolor: MaterialStateProperty.all<Color>(Colors.green[600]),
            borderColor: Colors.green[600],
            radius: 4.0,
            onPressed: isLoading ? null : () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }
}
