import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readb/auth.dart';
import 'package:readb/main.dart';
import 'package:readb/Home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share/share.dart';
import 'package:readb/method.dart';
import 'dart:ui';

class Sidedrawer extends StatelessWidget {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  User? user;
  bool isLogggedin = false;

  // SignOut() async {
  //   _auth.signOut();
  // }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.blueGrey[100],
            child: Center(
              child: Column(
                children: [
                  Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 25),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(user.photoURL.toString()),
                            fit: BoxFit.fill),
                      )),
                      SizedBox(
                        height: 10,
                      ),
                  Text(
                    user.displayName.toString(),
                    // user.displayName,

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              "Profile",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text(
              "Share",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Share.share(
                  "Listen this song https://www.youtube.com/watch?v=kJQP7kiw5Fk Most viewed song in the world",
                  subject: "Despacito Song");
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text(
              "Logout",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              logOut()
                  .whenComplete(() => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => Auth(),
                      ),
                      (route) => false));
            },
          ),
        ],
      ),
    );
  }
}
