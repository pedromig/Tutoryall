import 'package:flutter/material.dart';
import 'package:tutoryall/utils/date_picker.dart';
import 'package:tutoryall/utils/time_picker.dart';
import 'package:tutoryall/utils/tutoryall_event.dart';
import 'package:tutoryall/utils/tutoryall_user.dart';

class CreateEventScreen extends StatefulWidget {
  final TutoryallUser user;

  CreateEventScreen(this.user);

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  TutoryallEvent event;
  String eventID;
  String name;
  String description;
  DateTime date;
  TimeOfDay time;
  Image image;
  String location;
  double rating = 0;
  int lotation;
  List<String> tags;

  DateTime now = DateTime.now();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(
          "Create Event",
          style: TextStyle(
              fontSize: 25,
              fontFamily: 'Minimo',
              fontWeight: FontWeight.w800,
              color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff7ceccc),
        leading: Builder(
          builder: (context) => IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () => {Navigator.pop(context)}),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            // Event
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Event',
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
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Description
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Description',
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
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Date
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Date',
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
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: TextFieldDatePicker(
                prefixIcon: Icon(Icons.date_range),
                suffixIcon: Icon(Icons.arrow_drop_down),
                lastDate: DateTime.now().add(Duration(days: 366)),
                firstDate: DateTime.now(),
                initialDate: DateTime.now().add(Duration(days: 1)),
                onDateChanged: (selectedDate) {
                  // Do something with the selected date
                },
              ),
            ),

            // Time
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Time',
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
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: TextFieldTimePicker(
                prefixIcon: Icon(Icons.timer),
                suffixIcon: Icon(Icons.arrow_drop_down),
                initialTime: DateTime.now(),
                onTimeChanged: (selectedTime) {
                  // Do something with the selected time
                },
              ),
            ),

            // Location
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Location',
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
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Description
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Lotation',
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
              padding: EdgeInsets.only(left: 25.0, right: 280.0, top: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                padding: EdgeInsets.symmetric(horizontal: 1),
                color: Color(0xff7ceccc),
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 13),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color(0xff7ceccc)),
                    child: Text(
                      "Create",
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Minimo',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
