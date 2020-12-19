import 'package:flutter/material.dart';
import 'package:tutoryall/utils/tutoryall_event.dart';
import 'package:tutoryall/utils/tutoryall_user.dart';

class EditEventScreen extends StatefulWidget {
  TutoryallUser user;
  TutoryallEvent event;

  EditEventScreen({this.user, this.event});

  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  String name;
  String description;
  DateTime date;
  TimeOfDay time;
  Image image;
  String location;
  double rating = 0;
  int lotation;

  DateTime now = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    date = widget.event.date;
    time = widget.event.time;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit event"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            ListTile(
                title: Text("Name"),
                subtitle: TextFormField(
                  decoration: InputDecoration(hintText: "${widget.event.name}"),
                  initialValue: '',
                  validator: (value) {},
                  onSaved: (value) {
                    if (!value.trim().isEmpty) {
                      widget.event.name = value;
                    }
                  },
                )),
            ListTile(
                title: Text("Description"),
                subtitle: TextFormField(
                  decoration:
                      InputDecoration(hintText: "${widget.event.description}"),
                  initialValue: '',
                  validator: (value) {},
                  onSaved: (value) {
                    if (!value.trim().isEmpty) {
                      widget.event.description = value;
                    }
                  },
                )),
            ListTile(
              title: Text("Date"),
              subtitle: Text("${date.year}-${date.month}-${date.day}"),
              onTap: () {
                showDatePicker(
                  initialEntryMode: DatePickerEntryMode.input,
                  context: context,
                  initialDate: date = widget.event.date,
                  firstDate: now,
                  lastDate: DateTime(now.year + 10),
                ).then((_date) {
                  setState(() {
                    date = _date != null ? _date : date;
                  });
                });
              },
            ),
            ListTile(
              title: Text("Time"),
              subtitle: Text("${time.hour}:${time.minute}"),
              onTap: () {
                showTimePicker(context: context, initialTime: time)
                    .then((_time) {
                  setState(() {
                    time = _time != null ? _time : time;
                  });
                });
              },
            ),
            ListTile(
                title: Text("Location"),
                subtitle: TextFormField(
                  decoration:
                      InputDecoration(hintText: "${widget.event.location}"),
                  initialValue: '',
                  validator: (value) {},
                  onSaved: (value) {
                    if (!value.trim().isEmpty) {
                      widget.event.location = value;
                    }
                  },
                )),
            ListTile(
              title: Text("Lotation"),
              subtitle: TextFormField(
                decoration:
                    InputDecoration(hintText: "${widget.event.lotation}"),
                initialValue: '',
                validator: (value) {
                  if (!value.trim().isEmpty && !isIntNumber(value)) {
                    return "Invalid lotation value.";
                  }
                },
                onSaved: (value) {
                  if (!value.trim().isEmpty && isIntNumber(value)) {
                    widget.event.lotation = int.parse(value);
                  }
                },
              ),
            ),
            RaisedButton(
              child: Text("Guardar"),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  widget.event.date = date;
                  widget.event.time = time;
                  _formKey.currentState.reset();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  //TODO completar isto
  bool isDate(String date) {
    //parse da string
    int year, month, day;
    List<String> aux = date.split('/');
    year = int.parse(aux[0]);
    month = int.parse(aux[1]);
    day = int.parse(aux[2]);
    //criar date

    //obter
    return true;
  }

  bool isIntNumber(String number) {
    //quero que seja um inteiro
    if (number.isEmpty) {
      return false;
    }
    return int.tryParse(number) != null;
  }
}
