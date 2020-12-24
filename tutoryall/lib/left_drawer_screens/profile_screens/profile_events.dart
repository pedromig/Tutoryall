import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutoryall/utils/custom_tile.dart';
import 'package:tutoryall/utils/database.dart';
import 'package:tutoryall/utils/tutoryall_event.dart';
import 'package:tutoryall/utils/tutoryall_user.dart';

class ProfileEvent extends StatefulWidget {
  final String userID;
  ProfileEvent(this.userID);
  @override
  _ProfileEventState createState() => _ProfileEventState();
}

class _ProfileEventState extends State<ProfileEvent> {
  final _formKey = GlobalKey<FormState>();

  Future<List<TutoryallEvent>> _getData() async {
    List<TutoryallEvent> eventList = await Database.getEventList();
    TutoryallUser user = await Database.getUser(widget.userID);
    List<TutoryallEvent> filteredEvents = [];
    for (final ev in eventList) {
      if ((ev.creatorID == widget.userID) ||
          (user.goingEventsIDs.contains(ev.eventID))) {
        filteredEvents.add(ev);
      }
    }
    return filteredEvents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Color(0xff7ceccc),
        title: Text(
          "Featured Events",
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Minimo',
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return ProfileEvent(widget.userID);
                  },
                  transitionDuration: Duration(seconds: 0),
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: _getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading")));
            } else {
              if (snapshot.data.length != 0) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: CustomTile(snapshot, index, "ProfileEvents"));
                  },
                );
              } else {
                return Center(
                  child: Text("No Featured events to display"),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
