import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScienceFiction extends StatefulWidget {
  const ScienceFiction({ Key? key }) : super(key: key);

  @override
  _ScienceFictionState createState() => _ScienceFictionState();
}

class _ScienceFictionState extends State<ScienceFiction> {
 late String urlv;
  late String titlev;

  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Book')
            .doc("pbFzb2MrdYvwN3xMqv7d")
            .collection('Science Fiction')
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
    );
  }
}

Widget PostUI(String image, String Title, String Story, String Author,String Discription) {
  return new Card(
    shadowColor: Colors.white70,
    child: Builder(
      builder: (context) => Row(
        children: <Widget>[
          Column(
            children: [
              Container(
                child: Container(
                  height: 150,
                  width: 90,
                  margin: EdgeInsets.fromLTRB(20, 10, 10, 15),
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
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    padding:
                        EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
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
  );
}