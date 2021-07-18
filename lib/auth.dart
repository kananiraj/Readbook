import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readb/MainHome.dart';
import 'package:readb/discription.dart';
import 'package:readb/main.dart';
import 'package:readb/material.dart';
import 'package:readb/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:readb/method.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:readb/story.dart';
import 'package:shared_preferences/shared_preferences.dart';

//void main() => runApp(Auth());

class Auth extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Signin APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff9C58D2),
      ),
      home: GoogleSignApp(),
      routes: <String, WidgetBuilder>{
        '/discription': (BuildContext context) => new discription(),
        '/story': (BuildContext context) => new story(),
      },
    );
  }
}

class GoogleSignApp extends StatefulWidget {
  @override
  _GoogleSignAppState createState() => _GoogleSignAppState();
}

class _GoogleSignAppState extends State<GoogleSignApp> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googlSignIn = new GoogleSignIn();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    //navigateUser();
  }

  // void navigateUser() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var status = prefs.getBool('isLoggedIn') ?? false;
  //   print(status);
  //   if (status) {
  //     Navigation.pushReplacement(context, "/Home");
  //   } else {
  //     Navigation.pushReplacement(context, "/Login");
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.0),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 120, 0, 0),
                  // alignment: Alignment.centerLeft,
                  child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10),
                      child: RichText(
                          text: TextSpan(
                              text: 'Sign in',
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                            TextSpan(
                                text: ' Yourself',
                                style: TextStyle(
                                    color: Colors.lightBlue[300],
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold))
                          ]))),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 10),
                  // alignment: Alignment.centerLeft,
                  child: Container(
                      child: Text(
                    ' To Explore',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  )),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 10),
                  // alignment: Alignment.centerLeft,
                  child: Container(
                      child: Text(
                    ' More',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  )),
                ),
                Container(
                  child: Image.asset(
                    'images/logo.png',
                    height: 350,
                    width: 350,
                  ),
                ),
                Container(
                    width: 350.0,
                    height: 50,
                    child: Align(
                      alignment: Alignment.center,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0)),
                          color: Color(0xffffffff),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.google,
                                 color: Colors.lightBlue[500],
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                'Sign in with Google',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22.0),
                              ),
                            ],
                          ),
                          onPressed: () {
                            signInWithGoogle().then((user) {
                              if (user != null) {
                                setState(() {
                                  isLoading = false;
                                });
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        elevation: 8,
                                        child: Container(
                                          height: 180,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Center(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text('You have',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors
                                                              .indigo[900],
                                                        )),
                                                    Text(
                                                        'Logged in successfully!',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors
                                                              .indigo[900],
                                                        )),
                                                    SizedBox(height: 20),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        MainHome(),
                                                              ));
                                                        },
                                                        child: Text(
                                                          'Ok',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .indigo[900],
                                                          ),
                                                        ))
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            });
                          }),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;

  UserDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData);
}

class ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}
