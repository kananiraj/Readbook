//import 'dart:html';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readb/Sidedrawer.dart';

class Profile extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  Widget build(BuildContext context) {
    Widget _getHeader() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 40),
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  //borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(user.photoURL.toString()))
                  // color: Colors.orange[100],
                  ),
            ),
          ),
        ],
      );
    }

    Widget _profileName(String name) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.80, //80% of width,
        child: Center(
          child: Text(
            name,
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800),
          ),
        ),
      );
    }

    Widget _heading(String heading) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.80, //80% of width,
        child: Text(
          heading,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }

    Widget _detailsCard() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          child: Column(
            children: [
              //row for each deatails
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  user.displayName.toString(),
                ),
              ),
              Divider(
                height: 0.2,
                color: Colors.black87,
              ),
              ListTile(
                leading: Icon(Icons.email),
                title: Text(
                  user.email.toString(),
                ),
              ),
              Divider(
                height: 0.6,
                color: Colors.black87,
              ),
             
            ],
          ),
        ),
      );
    }

    Widget _settingsCard() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          child: Column(
            children: [
              //row for each deatails
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
              ),
              Divider(
                height: 0.6,
                color: Colors.black87,
              ),
              ListTile(
                leading: Icon(Icons.dashboard_customize),
                title: Text("About Us"),
              ),
              Divider(
                height: 0.6,
                color: Colors.black87,
              ),
              ListTile(
                leading: Icon(Icons.topic),
                title: Text("Change Theme"),
              )
            ],
          ),
        ),
      );
    }

    Widget logoutButton() {
      return InkWell(
        onTap: () {},
        child: Container(
            color: Colors.orange,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Logout",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            )),
      );
    }

    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: TextStyle(
                color: Colors.indigo[900], fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          // iconTheme: IconThemeData(color: Colors.green),
          leading: IconButton(
            icon: Icon(Icons.sort),
            color: Colors.indigo[900],
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        drawer: Sidedrawer(),
        body: Container(
          child: Container(
            child: SafeArea(
                child: Column(
              children: [
                //for circle avtar image
                _getHeader(),
                SizedBox(
                  height: 10,
                ),
                //  _profileName("Raj Jani"),
                SizedBox(
                  height: 14,
                ),
                _heading("Personal Details"),
                SizedBox(
                  height: 6,
                ),
                _detailsCard(),
                SizedBox(
                  height: 10,
                ),
               // _heading("Settings"),
                SizedBox(
                  height: 6,
                ),
               // _settingsCard(),
                Spacer(),
                //logoutButton()
              ],
            )),
          ),
        ),
      ),
    );
  }
}
