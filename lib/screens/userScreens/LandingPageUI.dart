import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noa/common_widgets/custom_elevated_button.dart';

class LandingPageUI extends StatelessWidget {
  const LandingPageUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.brown[200],
          child: Stack(
            children: [
              Positioned.fill(
                  child:Opacity(
                    opacity: 0.6,
                    child: Image.asset(
                      'assets/signin/back4.jpg',
                      fit: BoxFit.cover,),
                  ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Splant', style: TextStyle(
                            fontSize: 70,
                            fontFamily: 'IndieFlower',
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),),
                          Icon(FontAwesomeIcons.leaf, size: 20, color: Colors.white,)
                        ],
                      ),
                    ),
                    SizedBox(height: 70,),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                      child: CustomElevatedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons.google,
                              size: 22,
                              color: Colors.red,),
                              SizedBox(width: 14,),
                              Text(
                                'Sign in with Google',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'IndieFlower',
                                  fontSize: 22.0,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                          bgcolor: MaterialStateProperty.all<Color>(Colors.white70),
                          borderColor: Colors.redAccent[200],
                          radius: 20.0,),
                    ),
                     //   onPressed: isLoading ? null : () =>
                       // _signInWithGoogle(context)),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                      child: CustomElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Icon(FontAwesomeIcons.facebookF,
                            color: Colors.blue[900],
                            size: 22,),
                            SizedBox(width: 5,),
                            Text(
                              'Sign in with Facebook',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'IndieFlower',
                                  fontSize: 22.0,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        bgcolor: MaterialStateProperty.all<Color>(Colors.white70),
                        borderColor: Colors.blue[900],
                        radius: 20.0,
                       // onPressed: isLoading ? null : () => _signInWithFacebook(context),
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
                           Icon(FontAwesomeIcons.envelope, size:22 , color: Colors.green[900],),
                            SizedBox(width: 24,),
                            Text(
                              'Sign in with Email',
                              style: TextStyle(
                                color: Colors.black87,
                                fontFamily: 'IndieFlower',
                                fontSize: 22.0,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        bgcolor: MaterialStateProperty.all<Color>(Colors.white70),
                        borderColor: Colors.green[900],
                        radius: 20.0,
                      //  onPressed: isLoading ? null : () => _signInWithEmail(context),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ));
  }
}
