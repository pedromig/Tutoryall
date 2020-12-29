import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tutoryall/core_screens/home_page.dart';
import 'package:tutoryall/utils/database.dart';
import 'package:tutoryall/utils/tutoryall_user.dart';

class EditProfile extends StatefulWidget {
  TutoryallUser user;

  EditProfile(this.user);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = ImagePicker();

  Future _profileFuture;
  Future _backgroundFuture;

  _editProfileImage() async {
    PermissionStatus perm = await Permission.storage.request();
    if (perm.isGranted) {
      PickedFile image = await _imagePicker.getImage(
        source: ImageSource.gallery,
      );

      if (image != null) {}
      Database.updateProfileImage(
        File(image.path),
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Color(0xfff2f3f5),
            content: new Row(
              children: [
                CircularProgressIndicator(value: null),
                Container(
                    margin: EdgeInsets.only(left: 7),
                    child: Text("Uploading...")),
              ],
            ),
          );
        },
      );
      Future.delayed(const Duration(milliseconds: 3000), () {
        setState(() {
          _profileFuture = _getProfileImage();
        });
        Navigator.pop(context);
      });
    }
  }

  _editBackgroundImage() async {
    PickedFile image = await _imagePicker.getImage(
      source: ImageSource.gallery,
      maxHeight: 480,
      maxWidth: 640,
      imageQuality: 50,
    );
    Database.updateBackGroundImage(
      File(image.path),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: Color(0xfff2f3f5),
          content: new Row(
            children: [
              CircularProgressIndicator(value: null),
              Container(
                  margin: EdgeInsets.only(left: 7),
                  child: Text("Uploading...")),
            ],
          ),
        );
      },
    );
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {
        _backgroundFuture = _getBackgroundImage();
      });
      Navigator.pop(context);
    });
  }

  _getBackgroundImage() async {
    return await Database.getUserBackgroundImage(
        Database.authenticatedUser().uid);
  }

  _getProfileImage() async {
    return await Database.getUserProfilePicture(
        Database.authenticatedUser().uid);
  }

  _returnButton() {
    if (_formKey.currentState.validate()) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Color(0xfff2f3f5),
            content: new Row(
              children: [
                CircularProgressIndicator(value: null),
                Container(
                    margin: EdgeInsets.only(left: 7),
                    child: Text("Updating...")),
              ],
            ),
          );
        },
      );

      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context); // dialog
        Navigator.pop(context); // editprofile
        Navigator.pop(context); // profile
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return HomePage();
            },
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _profileFuture = _getProfileImage();
    _backgroundFuture = _getBackgroundImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
            onPressed: _returnButton,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Color(0xff7ceccc),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontSize: 25,
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
              future: _backgroundFuture,
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
                                      future: _profileFuture,
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
                            initialValue:
                                Database.authenticatedUser().displayName,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              if (value.length > 30) {
                                return "Max: 30 characters";
                              }
                              Database.updateUser(
                                Database.authenticatedUser().uid,
                                "name",
                                value,
                              );
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
                            initialValue: widget.user.contact,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              Database.updateUser(
                                  Database.authenticatedUser().uid,
                                  "contact",
                                  value);
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
                            initialValue: widget.user.age != -1
                                ? widget.user.age.toString()
                                : "",
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) return null;

                              int age = int.tryParse(value);
                              if (age == null ||
                                  int.parse(value) > 90 ||
                                  int.parse(value) < 10)
                                return 'Please Insert a valid age';
                              if (value.isNotEmpty)
                                Database.updateUser(
                                    Database.authenticatedUser().uid,
                                    "age",
                                    age);
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
                            initialValue: widget.user.location != "City"
                                ? widget.user.location
                                : "",
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: (value) {
                              if (value.isNotEmpty)
                                Database.updateUser(
                                    Database.authenticatedUser().uid,
                                    "location",
                                    value);
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
                            initialValue:
                                widget.user.bio != "Tell us more about you!"
                                    ? widget.user.bio
                                    : "",
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            scrollPadding: EdgeInsets.only(bottom: 1000),
                            maxLines: 7,
                            validator: (value) {
                              if (value.isNotEmpty)
                                Database.updateUser(
                                    Database.authenticatedUser().uid,
                                    "bio",
                                    value);
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
