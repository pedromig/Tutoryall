import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutoryall/left_drawer_screens/profile_screens/edit_profile.dart';
import 'package:tutoryall/left_drawer_screens/profile_screens/profile_info.dart';
import 'package:tutoryall/utils/database.dart';

class Profile extends StatefulWidget {
  final String userID;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Profile(this.userID);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isFav = true;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Database.getUser(widget.userID),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  backgroundColor: Color(0xff7ceccc),
                  title: Text("Loading", style: TextStyle(color: Colors.black)),
                  centerTitle: true),
              body: Center(child: Text("Loading")),
            );
          } else {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                backgroundColor: Color(0xff7ceccc),
                title: Text(snapshot.data.name,
                    style: TextStyle(color: Colors.black)),
                centerTitle: true,
                actions: <Widget>[
                  widget.userID != widget.auth.currentUser.uid
                      ? IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile()),
                            );
                          },
                        )
                      : IconButton(
                          icon: isFav == true
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.favorite_outline,
                                ),
                          onPressed: () {
                            setState(() {
                              isFav = !isFav;
                            });
                          }),
                ],
              ),
              body: ProfileInfo(snapshot.data),
            );
          }
        });
  }
}
