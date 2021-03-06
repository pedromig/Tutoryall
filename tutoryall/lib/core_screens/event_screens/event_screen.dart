import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutoryall/left_drawer_screens/profile_screens/profile.dart';
import 'package:tutoryall/utils/database.dart';
import 'package:tutoryall/utils/tutoryall_event.dart';
import 'package:tutoryall/utils/tutoryall_user.dart';

class EventScreen extends StatefulWidget {
  final TutoryallEvent event; //store event object
  final FirebaseAuth auth = FirebaseAuth.instance;
  //receives a event object
  EventScreen(this.event);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool ir = false;
  final int loggedUserIdx = 0;
  final int creatorUserIdx = 1;

  Future<List<TutoryallUser>> _getdata() async {
    List<TutoryallUser> users = [];
    TutoryallUser loggedUser =
        await Database.getUser(widget.auth.currentUser.uid);
    TutoryallUser creatorUser = await Database.getUser(widget.event.creatorID);
    users.add(loggedUser);
    users.add(creatorUser);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getdata(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                backgroundColor: Color(0xff7ceccc),
                title: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "Loading",
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Minimo',
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
              body: Center(
                child: Text("Loading"),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  snapshot.data[creatorUserIdx].id ==
                          widget.auth.currentUser.uid
                      ? Container()
                      : IconButton(
                          icon: widget.event.listGoingIDs
                                  .contains(widget.auth.currentUser.uid)
                              ? Icon(Icons.close)
                              : Icon(Icons.check),
                          onPressed: () {
                            setState(
                              () {
                                if (widget.event.listGoingIDs
                                    .contains(widget.auth.currentUser.uid)) {
                                  widget.event.listGoingIDs
                                      .remove(widget.auth.currentUser.uid);
                                  snapshot.data[loggedUserIdx].goingEventsIDs
                                      .remove(widget.event.eventID);
                                } else {
                                  widget.event.listGoingIDs
                                      .add(widget.auth.currentUser.uid);
                                  snapshot.data[loggedUserIdx].goingEventsIDs
                                      .add(widget.event.eventID);
                                }
                                Database.updateEvent(widget.event.eventID,
                                    "listGoingIDs", widget.event.listGoingIDs);
                                Database.updateUser(
                                    widget.auth.currentUser.uid,
                                    "goingEventsIDs",
                                    snapshot
                                        .data[loggedUserIdx].goingEventsIDs);
                              },
                            );
                          },
                        )
                ],
                centerTitle: true,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                backgroundColor: Color(0xff7ceccc),
                title: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    widget.event.name,
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Minimo',
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ),
              ),
              body: WillPopScope(
                onWillPop: () {
                  Navigator.pop(
                      context,
                      snapshot.data[creatorUserIdx].id ==
                              widget.auth.currentUser.uid
                          ? false
                          : (widget.event.listGoingIDs
                                  .contains(widget.auth.currentUser.uid)
                              ? false
                              : true)
                      );
                  return null;
                },
                child: Column(
                  children: [
                    FutureBuilder(
                      future: Database.getUserBackgroundImage(
                          widget.event.creatorID),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        return Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: snapshot.data == null
                                      ? Image.asset(
                                              "assets/images/cover_pic.png")
                                          .image
                                      : snapshot.data,
                                  fit: BoxFit.cover)),
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            child: FutureBuilder(
                              future: Database.getUserProfilePicture(
                                  widget.event.creatorID),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return GestureDetector(
                                  onTap: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Profile(
                                                widget.event.creatorID, true)));
                                    setState(() {});
                                  },
                                  child: Container(
                                    alignment: Alignment(-1.0, 2.5),
                                    child: CircleAvatar(
                                      backgroundImage: snapshot.data == null
                                          ? Image.asset(
                                                  "assets/images/default_user.png")
                                              .image
                                          : snapshot.data,
                                      radius: 50.0,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Center(
                        child: Text(
                          "${widget.event.location}\n${widget.event.date.day}/${widget.event.date.month}/${widget.event.date.year}\n${widget.event.time.hour}h${widget.event.time.minute}m",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        "Tutor Rating",
                      ),
                      trailing: FutureBuilder(
                        future: Database.getUser(widget.event.creatorID),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Text("Loading");
                          } else {
                            return Text(
                              snapshot.data.rating.toStringAsFixed(1),
                              style: TextStyle(fontSize: 15),
                            );
                          }
                        },
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        "Lotation",
                      ),
                      trailing: Text(
                          "${widget.event.listGoingIDs.length}/${widget.event.lotation}"),
                    ),
                    Divider(),
                    InkWell(
                      child: Container(
                        child: Text(
                          "${widget.event.description}",
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.fade,
                        ),
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => new AlertDialog(
                            title: new Text("Description"),
                            content: SingleChildScrollView(
                              child: new Text(
                                "${widget.event.description}",
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Divider(),
                  ],
                ),
              ),
            );
          }
        });
  }
}
