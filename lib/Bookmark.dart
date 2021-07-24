import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readb/MainHome.dart';
import 'package:readb/Sidedrawer.dart';
// working on this part is not started yet
class section extends StatelessWidget {
 
   Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Bookmark",
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
          child: Text('this is category'),            
      ),
      ),
    );
  }
}