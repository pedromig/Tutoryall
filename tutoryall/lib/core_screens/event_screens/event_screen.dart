import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
                body: Center(child: Text("Loading")));
          } else {
            return Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  snapshot.data[creatorUserIdx].id ==
                          widget.auth.currentUser.uid
                      ? IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {},
                        )
                      : IconButton(
                          icon: widget.event.listGoingIDs
                                  .contains(widget.auth.currentUser.uid)
                              ? Icon(Icons.close)
                              : Icon(Icons.check),
                          onPressed: () {
                            setState(() {
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
                                  snapshot.data[loggedUserIdx].goingEventsIDs);
                            });
                          })
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
                  Navigator.pop(context, snapshot.data[creatorUserIdx].id == widget.auth.currentUser.uid ? false :(widget.event.listGoingIDs.contains(widget.auth.currentUser.uid) ? false : true));
                  return null;
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://cdn.record.pt/images/2019-03/img_920x518\$2019_03_06_21_25_15_1514388.jpg"),
                              fit: BoxFit.cover)),
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push( 
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Profile(widget.event.creatorID,true)));
                            },
                            child: Container(
                              alignment: Alignment(-1.0, 2.5),
                              //é suposto esta imagem ser a do criador do evento
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://tmssl.akamaized.net/images/portrait/header/283130-1542106491.png?lm=1542106523"),
                                radius: 50.0,
                                backgroundColor: Colors.white,
                              ),
                            )),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Center(
                            child: Text(
                          "${widget.event.location}\n${widget.event.date.day}/${widget.event.date.month}/${widget.event.date.year}\n${widget.event.time.hour}h${widget.event.time.minute}m",
                          textAlign: TextAlign.center,
                        ))),
                    ListTile(
                      title: Text(
                        "Rating",
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
                    ListTile(
                        title: Text(
                          "Lotation",
                        ),
                        trailing: //Text("${widget.event.listGoing.length}/${widget.event.lotation}")),
                            Text(
                                "${widget.event.listGoingIDs.length}/${widget.event.lotation}")),
                    Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 20, bottom: 20),
                      child: Text(
                        widget.event.description,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
