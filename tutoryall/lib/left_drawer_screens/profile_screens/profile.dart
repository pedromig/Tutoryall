import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutoryall/left_drawer_screens/profile_screens/edit_profile.dart';
import 'package:tutoryall/left_drawer_screens/profile_screens/profile_info.dart';
import 'package:tutoryall/utils/database.dart';

class Profile extends StatefulWidget {
  final String userID;
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
                title: Text(
                  snapshot.data.name,
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Minimo',
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                  )
                ],
              ),
              body: ProfileInfo(snapshot.data),
            );
          }
        });
  }
}
