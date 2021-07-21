import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Educational extends StatefulWidget {
  const Educational({ Key? key }) : super(key: key);

  @override
  _EducationalState createState() => _EducationalState();
}

class _EducationalState extends State<Educational> {
  late String urlv;
  late String titlev;
  @override
 
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Book')
            .doc("pbFzb2MrdYvwN3xMqv7d")
            .collection('Educational')
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

Widget PostUI(String image, String Title, String Story, String Author,
    String Discription)
     {
  var c_width;
  return new Card(
    color: Colors.white,
    // shadowColor: Colors.white70,
    child: Builder(
      builder: (context) => Container(

        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: <Widget>[
            Column(
              children: [
                Container(
                  height: 120,
                  width: 90,
                  margin: EdgeInsets.fromLTRB(3, 10, 10, 15),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Container(
                  width: 150,

                   padding: EdgeInsets.fromLTRB(0, 20, 0, 80),
                  // margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
            Container(
              child: Align(
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/discription', arguments: {
                      'image': '$image',
                      'Title': '$Title',
                      'Discription': '$Discription',
                      'Story': '$Story',
                      'Author': '$Author'
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
