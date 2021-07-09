//import 'dart:io';
// @dart=2.9

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:readb/Data/data.dart';
import 'package:readb/allsection/ActionAdvanture.dart';
import 'package:readb/auth.dart';
import 'package:readb/Home.dart';
import 'package:readb/MainHome.dart';
import 'package:readb/discription.dart';
import 'package:readb/method.dart';
import 'package:readb/onbording.dart';
import 'package:readb/story.dart';
import 'package:shared_preferences/shared_preferences.dart';


int isViewed;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard');
  runApp(MaterialApp(home:MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder> {
        '/discription': (BuildContext context) => new discription(),
        '/story' : (BuildContext context) => new story(),
      },
    );
  }
}

class Home extends StatefulWidget {
    const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{

   AnimationController _animationController;
   Animation<double> _animation;
  
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    _animationController.forward();

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // isViewed != 0
        //     ? Navigator.pushReplacement(context,
        //         MaterialPageRoute(builder: (context) => Onbording_screen()))
        //     : Navigator.pushReplacement(
        //         context, MaterialPageRoute(builder: (context) => HomeScreen()));

        if(isViewed != 0){
          Navigator.pushReplacement(this.context,
                 MaterialPageRoute(builder: (context) => OnBording()));
        }
        else{
          if(FirebaseAuth.instance.currentUser == null){
            Navigator.pushAndRemoveUntil(this.context, MaterialPageRoute(builder: (context) => Auth()), (route) => false);
          }
          else{
            Navigator.pushReplacement(
                 this.context, MaterialPageRoute(builder: (context) => MainHome()));
          }
        }
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    super.initState();
  }

  Widget pageindexindicator(bool iscurrentpage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: iscurrentpage ? 10.0 : 6.0,
      width: iscurrentpage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: iscurrentpage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            'images/logo.png',
            height: 350,
            width: 350,
          ),
        )),
      ),
    );
  }
}