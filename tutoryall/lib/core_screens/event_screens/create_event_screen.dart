import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

class EventForm {
  String name;
  String description;
  DateTime date;
  DateTime time;
  String location;
  int lotation;
  List<String> tags = [];
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final formKey = GlobalKey<FormState>();
  final EventForm eventForm = EventForm();

  _getChips() {
    List<Widget> widgets = [];

    for (int i = 0; i < eventForm.tags.length; ++i) {
      widgets.add(
        Chip(
          label: Text(eventForm.tags[i]),
          onDeleted: () {
            setState(
              () {
                eventForm.tags.remove(eventForm.tags[i]);
              },
            );
          },
        ),
      );
    }
    widgets.add(
      ActionChip(
        label: Text("+"),
        onPressed: () => _addChip(widgets),
      ),
    );
    return widgets;
  }

  _addChip(List<Widget> widgets) {
    setState(
      () {
        TextEditingController _input = TextEditingController();
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              backgroundColor: Color(0xfff2f3f5),
              title: Text("Tag"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                          labelText: "Name",
                        ),
                        controller: _input,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Text('Add', style: TextStyle(color: Colors.black)),
                      onPressed: () async {
                        eventForm.tags.add(_input.text.trim());
                        widgets.add(
                          Chip(
                            label: Text(_input.text.trim()),
                          ),
                        );
                        Navigator.pop(context);
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

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
      body: Container(
        child: ListView(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  // Event
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
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
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
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
                              eventForm.name = value;
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Description
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
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
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                          child: TextFormField(
                            maxLines: 7,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              eventForm.description = value;
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Date
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
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
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                    child: TextFieldDatePicker(
                      prefixIcon: Icon(Icons.date_range),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      lastDate: DateTime.now().add(Duration(days: 366)),
                      firstDate: DateTime.now(),
                      initialDate: DateTime.now().add(Duration(days: 1)),
                      onDateChanged: (selectedDate) {
                        eventForm.date = selectedDate;
                      },
                    ),
                  ),

                  // Time
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
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
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
                    child: TextFieldTimePicker(
                      prefixIcon: Icon(Icons.timer),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      initialTime: DateTime.now(),
                      onTimeChanged: (selectedTime) {
                        eventForm.time = selectedTime;
                      },
                    ),
                  ),

                  // Location
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
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
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
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
                              eventForm.location = value;
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Lotation
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
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
                    padding:
                        EdgeInsets.only(left: 25.0, right: 270.0, top: 10.0),
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
                                return 'required';
                              }
                              int lotation = int.tryParse(value);
                              if (lotation == null) {
                                return "Invalid lotation";
                              }
                              eventForm.lotation = lotation;
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Tags:
            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'Tags',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 25.0, right: 10.0, top: 10.0),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 4.0,
                runSpacing: 1.0,
                children: _getChips(),
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
                    print(eventForm.name);
                    print(eventForm.description);
                    print(eventForm.date);
                    print(eventForm.time);
                    print(eventForm.location);
                    print(eventForm.lotation);
                    for (int i = 0; i < eventForm.tags.length; ++i) {
                      print(eventForm.tags[i]);
                    }
                  }
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
