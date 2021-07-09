//import 'dart:html';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readb/Sidedrawer.dart';

class Profile extends StatelessWidget {
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile",
            style: TextStyle(color: Colors.indigo[900], fontWeight: FontWeight.bold),
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
        body: Center(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(40),
            child: Text('this is profilr'),
          ),
        ),
      ),
    );
  }
}
