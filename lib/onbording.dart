import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readb/Data/data.dart';
import 'package:readb/MainHome.dart';
import 'package:readb/auth.dart';
import 'package:readb/discription.dart';
import 'package:readb/method.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(OnBording());
// }

class OnBording extends StatelessWidget {
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
      routes: <String, WidgetBuilder>{
        '/discription': (BuildContext context) => new discription(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<slidermodel> slides = <slidermodel>[];
  int currentindex = 0;
  PageController pageController = new PageController(initialPage: 0);

  void initState() {
    super.initState();
    slides = getlist();
  }

  Widget pageindexindicator(bool iscurrentpage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: iscurrentpage ? 10.0 : 6.0,
      width: iscurrentpage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: iscurrentpage ? Colors.orange : Colors.orange[100],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  _storeOnBoardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: slides.length,
        onPageChanged: (val) {
          setState(() {
            currentindex = val;
          });
        },
        itemBuilder: (context, index) {
          return Slider(
            imageasset: slides[index].getimagepath(),
            title: slides[index].gettitle(),
            des: slides[index].getdesc(),
          );
        },
      ),
      bottomSheet: currentindex != slides.length - 1
          ? Container(
              height: Platform.isIOS ? 70 : 60,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      pageController.animateToPage(slides.length - 1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.linear);
                    },
                    child: Text("SKIP",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                  Row(
                    children: [
                      for (int i = 0; i < slides.length; i++)
                        currentindex == i
                            ? pageindexindicator(true)
                            : pageindexindicator(false)
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      pageController.animateToPage(currentindex + 1,
                          duration: Duration(microseconds: 500),
                          curve: Curves.linear);
                    },
                    child: Text("NEXT" , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            )
          : InkWell(
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: Platform.isIOS ? 70 : 60,
                      color: Colors.orange[400],
                      child: Text(
                        "LET'S GET STARTED",
                        style: TextStyle(
                            color: Colors.black, fontSize : 15 ,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () async {
                await _storeOnBoardInfo();

                if (FirebaseAuth.instance.currentUser == null) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Auth()),
                      (route) => false);
                } else {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainHome()),
                      (route) => false);
                }
              }),
    );
  }
}

class Slider extends StatelessWidget {
  String imageasset, title, des;
  Slider({required this.imageasset, required this.title, required this.des});

  @override
  Widget build(BuildContext context) {
    return Container(
      //alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(30, 100, 30, 0),
      child: Column(
        
        children: [
         
          Container(child: Image.asset(imageasset)),
          SizedBox(
            height: 30,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Container(
                //alignment: Alignment.centerLeft,
          
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.orange[200],
                    // border: Border.all(
                    //     color: Colors.pink, // Set border color
                    //     width: 3.0),   // Set border width
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)), // Set rounded corner radius
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          color: Colors.orange,
                          offset: Offset(0.5,0.5))
                    ] // Make rounded corner of border
                    ),
                child: Text(title,
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            alignment: Alignment.centerLeft,
            child: Container(
                child: Text(
              des,style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
          ),
        ],
      ),
    );
  }
}
