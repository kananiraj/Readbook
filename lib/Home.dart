import 'dart:io';
import 'package:readb/Sidedrawer.dart';
import 'package:flutter/material.dart';
import 'package:readb/allsection/ActionAdvanture.dart';
import 'package:readb/allsection/ComicBook.dart';
import 'package:readb/allsection/Detective%20and%20Mystery.dart';
import 'package:readb/allsection/Educational.dart';
import 'package:readb/allsection/HistoricalFiction.dart';
import 'package:readb/allsection/Horror.dart';
import 'package:readb/allsection/Other.dart';
import 'package:readb/allsection/Romance.dart';
import 'package:readb/allsection/ScienceFiction.dart';
import 'main.dart';
import 'auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:readb/auth.dart';
import 'package:readb/UploadBook.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  String dropdownValue = 'One';
  late TabController _tabController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLogggedin = false;
  late User user;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Auth()));
      }
    });
  }

  getuser() async {
    User Firebaseuser = _auth.currentUser;
    await Firebaseuser.reload();
    Firebaseuser = _auth.currentUser;

    if (Firebaseuser != null) {
      setState(() {
        this.user = Firebaseuser;
        this.isLogggedin = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 9, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
          
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Home Page",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          // iconTheme: IconThemeData(color: Colors.green),
          leading: IconButton(
            icon: Icon(Icons.sort),
            color: Colors.black,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          bottom: new PreferredSize(
            preferredSize: new Size(0, 50),
            child: new Container(
              width: 477.0,
              height: 42,
              padding: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 10.0),
              child: new TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 6,
                        offset: Offset(-1, 1),
                      ),
                    ],
                    color: Colors.orange[500]),
                // onTap: (index) {
                //   switch (index) {
                //     case 0:
                //       // Navigator.push(
                //       //   context,
                //       //   MaterialPageRoute(
                //       //     builder: (context) => Actionadvanture(),
                //       //   ),
                //       // );
                //       break;
                //     case 1:
                //       Colors.red;
                //       break;
                //     case 2:
                //       Icons.label;
                //       break;
                //     case 3:
                //       Icons.label;
                //       break;
                //     case 4:
                //       // Navigator.push(
                //       //   context,
                //       //   MaterialPageRoute(
                //       //     builder: (context) => MyScreen(),
                //       //   ),
                //       // );
                //       break;
                //     case 5:
                //       Colors.red;
                //       break;
                //     case 6:
                //       Icons.label;
                //       break;
                //     case 7:
                //       Icons.label;
                //       break;
                //     case 8:
                //       Icons.label;
                //       break;
                //     default:
                //   }
                // },
                tabs: [
                  Tab(
                    child: Text(
                      'Action and Adventure',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Detective and Mystery',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Historical Fiction',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Comic Book',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Horror',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Romance',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Science Fiction',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Educational',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Other',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          child: TabBarView(
            controller: _tabController,
            children: [
              Actionadvanture(),
              DetectiveMystery(),
              HistoricalFication(),
              ComicBook(),
              Horror(),
              Romance(),
              ScienceFiction(),
              Educational(),
              Other(),
            ],
          ),
        ),
        drawer: Sidedrawer(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange[400],
          onPressed: () {
            // Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => UploadBook()));
          },
          highlightElevation: 10,
        ),
      ),
    ));
  }
}
