import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:tutoryall/core_screens/event_screens/event_screen.dart';
import 'package:tutoryall/left_drawer_screens/profile_screens/profile.dart';
import 'package:tutoryall/left_drawer_screens/profile_screens/profile_events.dart';
import 'package:tutoryall/utils/database.dart';
import 'package:tutoryall/utils/tutoryall_event.dart';

class CustomTile extends StatefulWidget {
  final AsyncSnapshot snapshot;
  final int index;
  final String tileLocation;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CustomTile(this.snapshot, this.index, this.tileLocation);
  @override
  _CustomTileState createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  bool delete = false;
  List<Widget> getTags() {
    List<Widget> tags = [];
    for (int i = 0;
        i < widget.snapshot.data[widget.index].tags.length && i < 3;
        i++) {
      if (i == 0) {
        tags.add(Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(CupertinoIcons.flame),
            ),
            label: Text(widget.snapshot.data[widget.index].tags[i])));
      } else {
        tags.add(Chip(label: Text(widget.snapshot.data[widget.index].tags[i])));
      }
    }
    return tags;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: Colors.red),
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: ListTile(
              onTap: () async {
                bool update = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventScreen(
                      TutoryallEvent(
                        widget.snapshot.data[widget.index].eventID,
                        widget.snapshot.data[widget.index].name,
                        widget.snapshot.data[widget.index].description,
                        widget.snapshot.data[widget.index].date,
                        widget.snapshot.data[widget.index].time,
                        widget.snapshot.data[widget.index].creatorID,
                        widget.snapshot.data[widget.index].listGoingIDs,
                        widget.snapshot.data[widget.index].location,
                        widget.snapshot.data[widget.index].lotation,
                        widget.snapshot.data[widget.index].tags,
                      ),
                    ),
                  ),
                );
                if (update && widget.tileLocation != "HomeMenu") {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProfileEvent(widget._auth.currentUser.uid)));
                }
              },
              leading: InkWell(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(
                            widget.snapshot.data[widget.index].creatorID,
                            true)),
                  )
                },
                child: FutureBuilder(
                  future: Database.getUserProfilePicture(
                      widget.snapshot.data[widget.index].creatorID),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return CircleAvatar(
                        backgroundImage: snapshot.data,
                      );
                    } else {
                      return CircleAvatar(
                        backgroundImage:
                            Image.asset("assets/images/default_user.png").image,
                      );
                    }
                  },
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.snapshot.data[widget.index].name,
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  Text(
                      '${widget.snapshot.data[widget.index].date.day}/${widget.snapshot.data[widget.index].date.month}/${widget.snapshot.data[widget.index].date.year} ${widget.snapshot.data[widget.index].time.hour}h${widget.snapshot.data[widget.index].time.minute}'),
                  Text('${widget.snapshot.data[widget.index].location}'),
                  Text(
                      "${widget.snapshot.data[widget.index].listGoingIDs.length}/${widget.snapshot.data[widget.index].lotation} people are going"),
                  Wrap(spacing: 8.0, runSpacing: 1.0, children: getTags()),
                ],
              ),
              trailing: Icon(
                Icons.event_note,
                size: 50,
              ),
              title: FutureBuilder(
                future: Database.getUser(
                    widget.snapshot.data[widget.index].creatorID),
                builder: (BuildContext buildContext, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Text("Loading");
                  } else {
                    return Text(
                      snapshot.data.name,
                      style: TextStyle(fontSize: 19),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
