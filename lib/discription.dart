import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readb/allsection/ActionAdvanture.dart';

class discription extends StatefulWidget {
  // // const discription({Key? key, required String urlv, required String titlev}) : super(key: key);

  @override
  _discriptionState createState() => _discriptionState();
}

class _discriptionState extends State<discription> {
  late String BookImg;
  late String BookTitle;
  late String BookDiscri;
  late String BookStory;
  late String BookAuth;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    BookImg = arguments['image'];
    BookTitle = arguments['Title'];
    BookDiscri = arguments['Discription'];
    BookStory = arguments['Story'];
    BookAuth = arguments['Author'];

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color(0xDDff5954),
        title: Text(
          'About',
          style: GoogleFonts.poppins(
              color: Colors.black, fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.black,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xffFFC341),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.yellow,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 6.0,
                    ),
                  ]),
              child: Hero(
                  tag: '$BookImg',
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 150,
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                        image: NetworkImage('$BookImg'),
                      ),
                    ),
                  )),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$BookTitle",
                    style: GoogleFonts.poppins(
                        fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "By " + "$BookAuth",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Description",
                    style: GoogleFonts.poppins(
                        fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [Text('$BookDiscri')],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  //alignment: Alignment.FractionalOffset.bottomCenter,,
                  padding: EdgeInsets.only(top: 30, bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    padding: EdgeInsets.only(
                        left: 50, top: 10, right: 50, bottom: 10),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/story', arguments: {
                        'Story': '$BookStory',
                        'Title': '$BookTitle'
                      });
                    },
                    color: Color(0xff2657ce),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                    ),
                    child: Text(
                      "Read Story....",
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
