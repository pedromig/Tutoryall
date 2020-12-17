import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutoryall/left_drawer_screens/profile_screens/edit_profile.dart';
import 'package:tutoryall/left_drawer_screens/profile_screens/profile_info.dart';
import 'package:tutoryall/utils/database.dart';
import 'package:tutoryall/utils/tutoryall_user.dart';

class Profile extends StatefulWidget {
  final String userID;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Profile(this.userID);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final int loggedUserIdx = 0;
  final int windowUserIdx = 1;

  Future<List<TutoryallUser>> _getdata() async {
    List<TutoryallUser> users = [];
    TutoryallUser loggedUser =
        await Database.getUser(widget.auth.currentUser.uid);
    TutoryallUser windowUser = await Database.getUser(widget.userID);
    users.add(loggedUser);
    users.add(windowUser);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userID);
    return FutureBuilder(
        future: _getdata(),
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
                title: Text("Profile",
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Minimo',
                        fontWeight: FontWeight.w800,
                        color: Colors.black)),
                centerTitle: true,
                actions: <Widget>[
                  widget.userID == widget.auth.currentUser.uid
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
                          icon: snapshot.data[loggedUserIdx].favUsersIDs
                                  .contains(widget.userID)
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.favorite_outline,
                                ),
                          onPressed: () {
                            setState(() {
                              if (snapshot.data[loggedUserIdx].favUsersIDs
                                  .contains(widget.userID)) {
                                snapshot.data[loggedUserIdx].favUsersIDs
                                    .remove(widget.userID);
                              } else {
                                snapshot.data[loggedUserIdx].favUsersIDs
                                    .add(widget.userID);
                              }
                              Database.updateUser(
                                  widget.auth.currentUser.uid,
                                  "favUsersIDs",
                                  snapshot.data[loggedUserIdx].favUsersIDs);
                            });
                          }),
                ],
              ),
              body: ProfileInfo(snapshot.data[windowUserIdx]),
            );
          }
        });
  }
}
