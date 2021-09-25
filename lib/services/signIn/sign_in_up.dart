import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noa/common_widgets/custom_elevated_button.dart';
import 'package:noa/common_widgets/showExceptionAlertDialog.dart';
import 'package:noa/services/Auth.dart';
import 'package:provider/provider.dart';
import 'EmailSignIn.dart';
import 'SignInManager.dart';

class SignInUp extends StatelessWidget {
  final SignInManager manager;
  final bool isLoading;
  bool isRegister = false;

  SignInUp({
    Key key,
    this.manager,
    this.isLoading,
    this.isRegister,
  }) : super(key: key);

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
            builder: (_, manager, __) => SignInUp(
              manager: manager,
              isLoading: isLoading.value,
            ),
          ),
        ),
      ),
    );
  }

  final bool isSignedIn = false;
  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(context,
        title: 'Sign in Failed', exception: exception);
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

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return
       Container(
      color: Colors.brown[200],
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: Image.asset(
                'assets/signin/back6.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50, ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Splant',
                          style: TextStyle(
                              fontSize: 70,
                              fontFamily: 'IndieFlower',
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Icon(
                          FontAwesomeIcons.leaf,
                          size: 20,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70, 100, 70, 0),
                    child: CustomElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.google,
                              size: 20,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            Text(
                              'Sign in with Google',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'IndieFlower',
                                  fontSize: 20.0,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        bgcolor:
                            MaterialStateProperty.all<Color>(Colors.white70),
                        borderColor: Colors.red[300],
                        radius: 20.0,
                        onPressed: isLoading
                            ? null
                            : () => _signInWithGoogle(context)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                    child: CustomElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.facebookF,
                            color: Colors.blue[900],
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Sign in with Facebook',
                            style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'IndieFlower',
                              fontSize: 20.0,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      bgcolor: MaterialStateProperty.all<Color>(Colors.white70),
                      borderColor: Colors.blue[700],
                      radius: 20.0,
                      onPressed:
                          isLoading ? null : () => _signInWithFacebook(context),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                    child: CustomElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.envelope,
                            size: 20,
                            color: Colors.green[900],
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Text(
                            'Sign in with Email',
                            style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'IndieFlower',
                              fontSize: 20.0,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      bgcolor: MaterialStateProperty.all<Color>(Colors.white70),
                      borderColor: Colors.green[400],
                      radius: 20.0,
                      onPressed:
                          isLoading ? null : () => _signInWithEmail(context),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
