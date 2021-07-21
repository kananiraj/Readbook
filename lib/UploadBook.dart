//import 'dart:html';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class UploadBook extends StatefulWidget {
  //
  @override
  _UploadBookState createState() => _UploadBookState();
}

class _UploadBookState extends State<UploadBook> {
  bool isuploading = false;
  String title = 'Upload post';

  var fnamecon = TextEditingController();
  var probcon = TextEditingController();
  var authercon = TextEditingController();
  var dicricon = TextEditingController();
  var catecon;
  var imagecon;
  StepperType _stepperType = StepperType.vertical;
  int _currentStep = 0;
  bool require = false;
  void handleSubmit() {
    setState(() {
      isuploading = true;
      uploadStatusImage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0, top: 10, bottom: 10),
            child: RaisedButton(
              textColor: Colors.white,
              color: Colors.orange,
              child: Text("Post"),
              onPressed: isuploading ? null : () => handleSubmit(),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
            ),
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.indigo[900]),
      ),
      body: SingleChildScrollView(
        child: Theme(
          data: ThemeData(
              // ignore: deprecated_member_use
              accentColor:Colors.orange,
              primarySwatch:Colors.orange,
              colorScheme: ColorScheme.light(primary: Colors.orange)),
          child: Column(
            children: [
              isuploading ? LinearProgressIndicator() : Text(" "),
              Stepper(
                steps: _stepper(),
                physics: ClampingScrollPhysics(),
                currentStep: this._currentStep,
                type: _stepperType,
                onStepTapped: (step) {
                  setState(() {
                    this._currentStep = step;
                  });
                },
                onStepContinue: () {
                  setState(() {
                    if (this._currentStep < this._stepper().length - 1) {
                      if (fnamecon.text.isNotEmpty ||
                          authercon.text.isNotEmpty ||
                          dicricon.text.isNotEmpty ||
                          probcon.text.isNotEmpty ||
                          _currentStep == 0 ||
                          _currentStep == 1) {
                        this._currentStep = this._currentStep + 1;
                        setState(() {
                          require = false;
                        });
                      } else {
                        setState(() {
                          require = true;
                        });
                      }
                    } else {
                      if (probcon.text.isNotEmpty) {
                        Fluttertoast.showToast(
                            msg: " Ready to Post",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.orange,
                            textColor: Colors.white,
                            fontSize: 16.0);

                        setState(() {
                          require = false;
                        });
                      } else {
                        setState(() {
                          require = true;
                        });
                      }
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (this._currentStep > 0) {
                      this._currentStep = this._currentStep - 1;
                    } else {
                      this._currentStep = 0;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  File? _image;
  late String myvalue;
  late String url;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? dropdownValue = 'Action and Adventure';

  Future getImage() async {
    // ignore: deprecated_member_use
    final image = await ImagePicker.pickImage(source: ImageSource.gallery)
        .then((image) async {
      if (image != null && await image.exists()) {
        print("image selected");
        setState(() {
          _image = image;
        });
      } else {
        print("image not selected");
        //other code
      }
    }).catchError((error) {
      print("Error: " + error.toString());
    });
  }

  void uploadStatusImage() async {
    var firebaseuser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final Reference postImageRef =
        FirebaseStorage.instance.ref().child("Post Image");

    var timekey = new DateTime.now();

    final UploadTask uploadTask =
        postImageRef.child(timekey.toString() + ".jpg").putFile(_image);

    var Imageurl = await (await uploadTask).ref.getDownloadURL();

    // // print("product name = " + myvalue);
    url = Imageurl.toString();
    print("Image url = " + url);
    //StorageTaskSnapshot addImg = await ref.child("image/img").putFile(image).onComplete;

    if (dropdownValue == 'Action and Adventure') {
      await FirebaseFirestore.instance
          .collection('Book')
          .doc('pbFzb2MrdYvwN3xMqv7d')
          .collection("Action and Adventure")
          .add({
        'Title': fnamecon.text,
        'Story': probcon.text,
        'Author': authercon.text,
        'Url': Imageurl,
        'Discription': dicricon.text,
      });
    } else if (dropdownValue == 'Detective and Mystery') {
      await FirebaseFirestore.instance
          .collection('Book')
          .doc('pbFzb2MrdYvwN3xMqv7d')
          .collection("Detective and Mystery")
          .add({
        'Title': fnamecon.text,
        'Story': probcon.text,
        'Url': Imageurl,
        'Author': authercon.text,
        'Discription': dicricon.text
      });
    } else if (dropdownValue == 'Historical Fiction') {
      await FirebaseFirestore.instance
          .collection('Book')
          .doc('pbFzb2MrdYvwN3xMqv7d')
          .collection("Historical Fiction")
          .add({
        'Title': fnamecon.text,
        'Story': probcon.text,
        'Url': Imageurl,
        'Author': authercon.text,
        'Discription': dicricon.text
      });
    } else if (dropdownValue == 'Comic Book') {
      await FirebaseFirestore.instance
          .collection('Book')
          .doc('pbFzb2MrdYvwN3xMqv7d')
          .collection("Comic Book")
          .add({
        'Title': fnamecon.text,
        'Story': probcon.text,
        'Url': Imageurl,
        'Author': authercon.text,
        'Discription': dicricon.text
      });
    } else if (dropdownValue == 'Horror') {
      await FirebaseFirestore.instance
          .collection('Book')
          .doc('pbFzb2MrdYvwN3xMqv7d')
          .collection("Horror")
          .add({
        'Title': fnamecon.text,
        'Story': probcon.text,
        'Url': Imageurl,
        'Author': authercon.text,
        'Discription': dicricon.text
      });
    } else if (dropdownValue == 'Romance') {
      await FirebaseFirestore.instance
          .collection('Book')
          .doc('pbFzb2MrdYvwN3xMqv7d')
          .collection("Romance")
          .add({
        'Title': fnamecon.text,
        'Story': probcon.text,
        'Url': Imageurl,
        'Author': authercon.text,
        'Discription': dicricon.text
      });
    } else if (dropdownValue == 'Science Fiction') {
      await FirebaseFirestore.instance
          .collection('Book')
          .doc('pbFzb2MrdYvwN3xMqv7d')
          .collection("Science Fiction")
          .add({
        'Title': fnamecon.text,
        'Story': probcon.text,
        'Url': Imageurl,
        'Author': authercon.text,
        'Discription': dicricon.text
      });
    } else if (dropdownValue == 'Educational') {
      await FirebaseFirestore.instance
          .collection('Book')
          .doc('pbFzb2MrdYvwN3xMqv7d')
          .collection("Educational")
          .add({
        'Title': fnamecon.text,
        'Story': probcon.text,
        'Url': Imageurl,
        'Author': authercon.text,
        'Discription': dicricon.text
      });
    } else {
      await FirebaseFirestore.instance
          .collection('Book')
          .doc('pbFzb2MrdYvwN3xMqv7d')
          .collection("Other")
          .add({
        'Title': fnamecon.text,
        'Story': probcon.text,
        'Url': Imageurl,
        'Author': authercon.text,
        'Discription': dicricon.text
      });
    }
  }

  List<Step> _stepper() {
    physics:
    ClampingScrollPhysics();
    List<Step> _steps = [
      Step(
          title: Text('Category'),
          content: DropdownButton<String>(
            // value: _chosenValue,
            //elevation: 5,
            style: TextStyle(color: Colors.black),
            value: dropdownValue,

            items: <String>[
              'Action and Adventure',
              'Detective and Mystery',
              'Historical Fiction',
              'Comic Book',
              'Horror',
              'Romance',
              'Science Fiction',
              'Educational',
              'Other',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            // hint: Text(
            //   "In which category your book fall ",
            //   style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 16,
            //       fontWeight: FontWeight.w600),
            // ),
            onChanged: (newValue) {
              setState(() {
                dropdownValue = newValue;
                print(dropdownValue);
              });
            },
          ),
          isActive: _currentStep >= 0,
          state: StepState.disabled),
      Step(
          title: Text('Image'),
          content: Column(
            children: <Widget>[
              Text('Upload your image here',
                  style: TextStyle(color: Colors.grey)),
              _image == null
                  ? Text("Image not Loaded")
                  : Image.file(
                      _image!,
                      height: 250,
                      width: 350,
                    ),

              // ignore: deprecated_member_use
              FlatButton(
                onPressed: () {
                  getImage();
                },
                child: Text('Upload',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                textColor: Colors.black,
                color: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                padding: EdgeInsets.all(8.0),
              )
            ],
          ),
          isActive: _currentStep >= 1,
          state: StepState.disabled),
      Step(
          title: Text('Author'),
          content: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    labelText: "Write a Author Name",
                    errorText: require ? "Value can't be empty" : null),
                controller: authercon,
              ),
            ],
          ),
          isActive: _currentStep >= 2,
          state: StepState.disabled),
      Step(
          title: Text('Title'),
          content: Column(
            children: <Widget>[
              TextFormField(
                controller: fnamecon,
                decoration: InputDecoration(
                    labelText: 'Story Title',
                    errorText: require ? "Value cannot be empty" : null),
              ),
            ],
          ),
          isActive: _currentStep >= 3,
          state: StepState.disabled),
      Step(
          title: Text('Discription'),
          content: Column(
            children: <Widget>[
              TextFormField(
                minLines: 1,
                controller: dicricon,
                decoration: InputDecoration(
                    labelText: 'Write a Discription',
                    errorText: require ? "Value cannot be empty" : null),
                    maxLength: 500,

              ),
            ],
          ),
          isActive: _currentStep >= 4,
          state: StepState.disabled),
      Step(
          title: Text('Story'),
          content: Column(
            children: <Widget>[
              TextFormField(
                minLines:
                    6, // any number you need (It works as the rows for the textarea)
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    labelText: "Write a Story",
                    errorText: require ? "Value can't be empty" : null),
                controller: probcon,
              ),
            ],
          ),
          isActive: _currentStep >= 5,
          state: StepState.disabled),
    ];
    return _steps;
  }
}
