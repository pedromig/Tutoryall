import 'package:flutter/material.dart';
import 'package:tutoryall/core_screens/event_screens/delete_event.dart';
import 'package:tutoryall/core_screens/event_screens/edit_event_screen.dart';
import 'package:tutoryall/core_screens/home_page.dart';
import 'package:tutoryall/utils/database.dart';
import 'package:tutoryall/utils/tutoryall_event.dart';
import 'package:tutoryall/utils/tutoryall_user.dart';

class MyEvents extends StatefulWidget {
  @override
  _MyEventsState createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  Future<List<TutoryallEvent>> _futureEvents;

  Future<List<TutoryallEvent>> _getEvents() async {
    String uid = Database.authenticatedUser().uid;
    TutoryallUser user = await Database.getUser(uid);

    List<TutoryallEvent> events = [];
    for (int i = 0; i < user.createdEventsIDs.length; ++i) {
      TutoryallEvent e = await Database.getEvent(user.createdEventsIDs[i]);
      events.add(e);
    }
    return events;
  }

  @override
  void initState() {
    super.initState();
    _futureEvents = _getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
            onPressed: () => {
              Navigator.pop(context),
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage())),
            },
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Color(0xff7ceccc),
        title: Text(
          "My Events",
          style: TextStyle(
              fontSize: 25,
              fontFamily: 'Minimo',
              fontWeight: FontWeight.w800,
              color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
          future: _futureEvents,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.data.length == 0) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Nothing to show here!"),
                  Text("Create a new event to get started.")
                ],
              ));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      leading: GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => DeleteEvent(
                            eventID: snapshot.data[index].eventID,
                          ),
                        ),
                        child: Icon(
                          Icons.delete,
                          size: 40,
                          color: Colors.red,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditEventScreen(event: snapshot.data[index]),
                            ),
                          )
                        },
                        child: Icon(Icons.edit, size: 40, color: Colors.blue),
                      ),
                      subtitle: Column(
                        children: <Widget>[
                          Text(snapshot.data[index].name,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                          Text(
                              '${snapshot.data[index].date.day}/${snapshot.data[index].date.month}/${snapshot.data[index].date.year} ${snapshot.data[index].time.hour}h${snapshot.data[index].time.minute == 0 ? "00" : snapshot.data[index].time.minute}'),
                          Text('${snapshot.data[index].location}'),
                          Text(
                              "${snapshot.data[index].listGoingIDs.length}/${snapshot.data[index].lotation} people are going"),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
