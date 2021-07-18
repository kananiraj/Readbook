//
//import 'dart:html';

//import 'dart:js';

//import 'dart:js';

import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:readb/discription.dart';

//external JsObject get context;
late String urlv;
late String titlev;

class Actionadvanture extends StatefulWidget {
  const Actionadvanture({Key? key}) : super(key: key);

  @override
  _ActionadvantureState createState() => _ActionadvantureState();
}

class _ActionadvantureState extends State<Actionadvanture> {
  @override
  late String urlv;
  late String titlev;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // decoration: new BoxDecoration(color: Colors.green[50]),

        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Book')
              .doc("pbFzb2MrdYvwN3xMqv7d")
              .collection('Action and Adventure')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var doc = snapshot.data!.docs;
              return new ListView.builder(
                  itemCount: doc.length,
                  itemBuilder: (context, index) {
                    return PostUI(
                      doc[index].data()['Url'],
                      doc[index].data()['Title'],
                      doc[index].data()['Story'],
                      doc[index].data()['Author'],
                      doc[index].data()['Discription'],
                    );
                  });
            } else {
              return LinearProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

Widget PostUI(String image, String Title, String Story, String Author,
    String Discription) {
  return new Card(
    color: Colors.green[50],
    shadowColor: Colors.white70,
    child: Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 15),
      child: Builder(
        builder: (context) => Container(
          // padding:EdgeInsets.fromLTRB(10, 10, 10, 15) ,
          child: Row(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    child: Container(
                      height: 150,
                      width: 90,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 15),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(image), fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(offset: Offset(5, 5), blurRadius: 5),
                          ]),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '$Title',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "By" + " $Author",
                          style: TextStyle(color: Colors.black45),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    // padding: EdgeInsets.only(top: 20, bottom: 20),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),

                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 10, bottom: 10),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/discription', arguments: {
                          'image': '$image',
                          'Title': '$Title',
                          'Discription': '$Discription',
                          'Story': '$Story'
                        });
                      },
                      color: Color(0xff2657ce),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                      child: Text(
                        "Explore",
                        style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

// void openCoursePage(String Ima, String title) {
//   // var route = new MaterialPageRoute(
//   //     builder: (BuildContext context) =>
//   //         new discription(urlv: Ima, titlev: title));
//   // Navigator.of(context).push(route);

//   Navigator.pushNamed(context, '/discription',
//       arguments: {'img': '$Ima', 'title': '$title'});
// }

// Widget PostUI(String image, String Title, String Story, String Author) {
//   return new Card(
//     elevation: 8.0,
//     color: Colors.grey[200],
//     shadowColor: Colors.blueGrey[900],
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(15.0),
//     ),
//     margin: EdgeInsets.all(7.0),
//     // margin: EdgeInsets.only(bottom:10),
//     child: new Container(
//         padding: new EdgeInsets.all(10.0),
//         child: new Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             new Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Container(
//                           width: 35,
//                           height: 35,
//                           margin: EdgeInsets.only(top: 0),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                                 image: AssetImage("images/raj.jpg"),
//                                 fit: BoxFit.fill),
//                           )),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 5.0),
//             new Image.network(
//               image,
//               height: 250,
//               width: 450,
//             ),
//             SizedBox(height: 5.0),
//             new Text(
//               Title,
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 5.0),
//             SizedBox(height: 5.0),
//             Container(
//               child: Row(
//                 children: [
//                   Container(
//                       width: 150,
//                       child: Column(
//                         children: [
//                           RaisedButton(
//                             onPressed: () {
//                               print("Like");
//                             },
//                             child: Column(
//                               children: <Widget>[
//                                 Row(children: [
//                                   Text('Like '),
//                                   Icon(Icons.thumb_up)
//                                 ]),
//                               ],
//                             ),
//                           ),
//                         ],
//                       )),
//                 ],
//               ),
//             )
//           ],
//         )),
//   );
// }

// onPressed: () {
//                                 Navigator.of(context)
//                                     .pushNamed('/discription', arguments: {
//                                   'image': '$image',
//                                   'Title': '$Title',
//                                   'Discription': '$Discription',
//                                   'Story': '$Story'
//                                 });
//                                 //arguments: ({'img': '$image', 'title': '$Title'});
//                                 //     var route = new MaterialPageRoute(
//                                 //       builder: (BuildContext context) =>
//                                 //           new discription(urlv: '$image', titlev: '$Title'));
//                                 // Navigator.of(context).push(route);
//                                 //  // openCoursePage('$image', '$Title');
//                               },
