import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:epub_viewer/epub_viewer.dart';

class story extends StatefulWidget {
  const story({Key? key}) : super(key: key);

  @override
  _storyState createState() => _storyState();
}

class _storyState extends State<story> {
  late String BookTitle;
  late String BookStory;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    BookTitle = arguments['Title'];
    BookStory = arguments['Story'];

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color(0xDDff5954),
        title: Text(
          'Story',
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
        child: SingleChildScrollView(
          child: Column(
            children: [
               SizedBox(
            height: 30,
          ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$BookTitle',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 7,
                        ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [Text('$BookStory')],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
