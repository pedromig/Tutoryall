import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tutoryall/left_drawer_screens/my_events.dart';
import 'package:tutoryall/utils/database.dart';
import 'package:tutoryall/utils/date_picker.dart';
import 'package:tutoryall/utils/time_picker.dart';
import 'package:tutoryall/utils/tutoryall_event.dart';

class EditEventScreen extends StatefulWidget {
  final TutoryallEvent event;

  EditEventScreen({this.event});

  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class EventEditForm {
  String name;
  String description;
  DateTime date;
  DateTime time;
  String location;
  int lotation;
  List<String> tags = [];

  EventEditForm({
    this.name,
    this.description,
    this.date,
    this.time,
    this.location,
    this.lotation,
    this.tags,
  });
}

class _EditEventScreenState extends State<EditEventScreen> {
  final formKey = GlobalKey<FormState>();
  EventEditForm eventForm;

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
          barrierDismissible: false,
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

  _returnButton() {
    if (formKey.currentState.validate()) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            backgroundColor: Color(0xfff2f3f5),
            content: new Row(
              children: [
                CircularProgressIndicator(value: null),
                Container(
                    margin: EdgeInsets.only(left: 7),
                    child: Text("Updating...")),
              ],
            ),
          );
        },
      );

      Database.newEvent(
        TutoryallEvent(
          widget.event.eventID,
          eventForm.name,
          eventForm.description,
          eventForm.date == null ? DateTime.now() : eventForm.date,
          eventForm.time == null
              ? TimeOfDay.now()
              : TimeOfDay.fromDateTime(eventForm.time),
          widget.event.creatorID,
          widget.event.listGoingIDs,
          eventForm.location,
          eventForm.lotation,
          eventForm.tags,
        ),
      );

      Future.delayed(
        Duration(seconds: 3),
        () {
          Navigator.pop(context); // dialog
          Navigator.pop(context); // editprofile
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return MyEvents();
              },
            ),
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    DateTime _now = DateTime.now();
    eventForm = EventEditForm(
      name: widget.event.name,
      description: widget.event.description,
      date: widget.event.date,
      time: DateTime(
        _now.year,
        _now.month,
        _now.day,
        widget.event.time.hour,
        widget.event.time.minute,
      ),
      location: widget.event.location,
      lotation: widget.event.lotation,
      tags: widget.event.tags,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(
          "Edit Event",
          style: TextStyle(
              fontSize: 25,
              fontFamily: 'Minimo',
              fontWeight: FontWeight.w800,
              color: Colors.black),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
            onPressed: _returnButton,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff7ceccc),
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
                            initialValue: eventForm.name,
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
                            initialValue: eventForm.description,
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
                      initialDate: eventForm.date,
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
                      initialTime: eventForm.time,
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
                            initialValue: eventForm.location,
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
                            initialValue: eventForm.lotation.toString(),
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

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
