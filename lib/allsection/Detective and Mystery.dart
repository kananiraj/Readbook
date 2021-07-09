import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetectiveMystery extends StatefulWidget {
  const DetectiveMystery({ Key? key }) : super(key: key);

  @override
  _DetectiveMysteryState createState() => _DetectiveMysteryState();
}

class _DetectiveMysteryState extends State<DetectiveMystery> {
  late String urlv;
  late String titlev;

  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Book')
            .doc("pbFzb2MrdYvwN3xMqv7d")
            .collection('Detective and Mystery')
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
   child: Builder(
        builder: (context) => Column(
        children: <Widget>[
          ClipPath(
            child: Container(
              padding: EdgeInsets.only(top: 40),
              height: 380,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xFF0F2027),
                    Color(0xFF203A43),
                    Color(0xFF2C5364),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        Title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  new Image.network(
                    image,
                    height: 250,
                    width: 450,
                  ),

                  // fit: BoxFit.fitWidth,

                  SizedBox(height: 10.0),
                  Text(
                    Author,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 3,
                )
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/discription',
                    arguments: {'image': '$image', 'Title': '$Title' , 'Discription':'$Discription' , 'Story' : '$Story'});
                      //arguments: ({'img': '$image', 'title': '$Title'});
                  //     var route = new MaterialPageRoute(
                  //       builder: (BuildContext context) =>
                  //           new discription(urlv: '$image', titlev: '$Title'));
                    // Navigator.of(context).push(route);
                  //  // openCoursePage('$image', '$Title');
                  },
                  child: const Text('Click Me'),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}