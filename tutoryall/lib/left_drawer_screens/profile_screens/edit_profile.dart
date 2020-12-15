import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutoryall/utils/database.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();

  _editProfileImage() async {
    PickedFile image = await _imagePicker.getImage(
      source: ImageSource.gallery,
    );
    Database.updateProfileImage(
      File(image.path),
    );
  }

  _editBackgroundImage() async {
    PickedFile image = await _imagePicker.getImage(
      source: ImageSource.gallery,
    );
    Database.updateBackGroundImage(
      File(image.path),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Color(0xff7ceccc),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 35,
            fontFamily: 'Minimo',
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
            // User and Background Image Stack
            FutureBuilder(
              future: Database.getUserBackgroundImage(
                  Database.authenticatedUser().uid),
              builder: (BuildContext context,
                  AsyncSnapshot backgroundImageSnapshot) {
                if (backgroundImageSnapshot.data != null) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: backgroundImageSnapshot.data,
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 160,
                              child: Container(
                                alignment: Alignment(-0.95, 2.1),
                                child: GestureDetector(
                                  child: InkWell(
                                    onTap: _editProfileImage,
                                    child: FutureBuilder(
                                      future: Database.getUserProfilePicture(
                                          Database.authenticatedUser().uid),
                                      builder: (context, snapshot) {
                                        if (snapshot.data != null) {
                                          return CircleAvatar(
                                            backgroundImage: snapshot.data,
                                            radius: 50.0,
                                            backgroundColor: Colors.black,
                                          );
                                        } else {
                                          return CircleAvatar(
                                            radius: 50.0,
                                            backgroundColor: Colors.black,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Edit Background Image Icon
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width - 50, 5, 0, 0),
                        child: InkWell(
                          onTap: _editBackgroundImage,
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 17.0,
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Text("Loading...");
                }
              },
            ),

            // Edit User Image Icon
            Container(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width / 10 - 30, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: _editProfileImage,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 20.0,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Personal Information
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
              child: Text(
                'Personal Information',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),

            // Divider
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 3.0),
              child: Divider(
                thickness: 2,
                color: Colors.black26,
              ),
            ),

            // User Information Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Name
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Name',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Contact
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Contact',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Age
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Age',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (int.parse(value) > 90 ||
                                  int.parse(value) < 10)
                                return 'Please Insert a valid age';
                              else
                                return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Location
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Country / City',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (int.parse(value) > 90 ||
                                  int.parse(value) < 10)
                                return 'Please Insert a valid age';
                              else
                                return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Biograpy
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Biography',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            scrollPadding: EdgeInsets.only(bottom: 1000),
                            maxLines: 5,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.width / 30),
                alignment: Alignment.center,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 3),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Color(0xff7ceccc),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    }
                  },
                  child: Text('Submit'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
