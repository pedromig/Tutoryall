import 'package:flutter/material.dart';
import 'package:tutoryall/left_drawer_screens/my_events.dart';
import 'package:tutoryall/utils/database.dart';
import 'package:tutoryall/utils/tutoryall_user.dart';

class DeleteEvent extends StatefulWidget {
  String eventID;
  DeleteEvent({this.eventID});

  @override
  _DeleteEventState createState() => _DeleteEventState();
}

class _DeleteEventState extends State<DeleteEvent> {
  _deleteEvent() async {
    String removeEventId = widget.eventID;
    List<TutoryallUser> users = await Database.getUserList();
    int ind = removeEventId.indexOf("_");

    await Database.fb.reference().child("events").child(removeEventId).remove();
    await Database.fb
        .reference()
        .child("users")
        .child(Database.authenticatedUser().uid)
        .child("createdEventsIDs")
        .child(removeEventId.substring(ind + 1))
        .remove();

    for (TutoryallUser user in users) {
      if (user.id != Database.authenticatedUser().uid &&
          user.goingEventsIDs != null) {
        for (int i = 0; i < user.goingEventsIDs.length; ++i) {
          if (user.goingEventsIDs[i] == removeEventId) {
            await Database.fb
                .reference()
                .child("users")
                .child(user.id)
                .child("goingEventsIDs")
                .child(i.toString())
                .remove();
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: Color(0xfff2f3f5),
      title: Center(
        child: Text('Delete Event'),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Center(child: Text('Do you wish to delete this event?')),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              color: Color(0xffed2a18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              child: Text('Yes', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await _deleteEvent();
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyEvents(),
                  ),
                );
              },
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              child: Text('No, take me back!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
