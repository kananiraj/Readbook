import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readb/Home.dart';
import 'package:readb/Profile.dart';
import 'package:readb/Sidedrawer.dart';
import 'package:readb/discription.dart';
import 'package:readb/Bookmark.dart';
import 'package:readb/story.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   //await Firebase.initializeApp();
//   runApp(MainHome());
// }

class MainHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HOME",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      routes: <String, WidgetBuilder> {
        '/discription': (BuildContext context) => new discription(),
        '/story' : (BuildContext context) => new story(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, required this.title}) : super(key: key);
  late final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 // FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectpage = 0;
  final _pageOption = [Home(),section(),Profile(),];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      drawer: Sidedrawer(),
      body: _pageOption[_selectpage],
      backgroundColor: Colors.green[200],
      bottomNavigationBar: ConvexAppBar(
        color: Colors.black,
        backgroundColor: Colors.white,
        activeColor: Colors.orange[400],
        items: [
          TabItem(
            icon: Icons.home,
            title: 'Home',
          ),
         
          TabItem(icon: Icons.article, title: 'Bookmark'),
           TabItem(icon: Icons.forum, title: 'Profile'),
         // TabItem(icon: Icons.person, title: 'Profile'),
        ],
        initialActiveIndex: 0,
        onTap: (int index) {
          setState(() {
            _selectpage = index;
          });
        },
      ),
    );
  }
}
