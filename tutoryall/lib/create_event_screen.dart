import 'package:flutter/material.dart';
import 'event_screen.dart'; //para ter acesso à classe Event

import 'package:date_field/date_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateEventScreen extends StatefulWidget {
  User user;

  CreateEventScreen(
      this.user); //para ter acesso ao user dentro do _CreateEventScreenState

  @override
  _CreateEventScreenState createState() {
    return _CreateEventScreenState();
  }
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  Event event;
  String name;
  String description;
  DateTime date;
  TimeOfDay time;
  Image image;
  List<User> listGoing; //daqui sai vazia, mais tarde vão ser adicionados
  String location;
  double rating = 0; //pelo que percebi, vai ser calculado posteriormente
  int lotation;

  DateTime now = DateTime.now();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create event"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            ListTile(
                title: Text("Name"),
                subtitle: TextFormField(
                  decoration: InputDecoration(hintText: "insert name"),
                  initialValue: '',
                  validator: (value) {
                    //!aceitar nomes com números? parece-me correto, não sei se é correto restringir nomes
                    if (value.trim().isEmpty) {
                      return "Invalid name.";
                    }
                  },
                  onSaved: (value) {
                    name = value;
                  },
                )),
            ListTile(
                title: Text("Description"),
                subtitle: TextFormField(
                  decoration: InputDecoration(hintText: "insert description"),
                  initialValue: '',
                  validator: (value) {
                    //!talvez aceitar mesmo quando a descrição está vazia???
                    if (value.trim().isEmpty) {
                      return "Empty description.";
                    }
                  },
                  onSaved: (value) {
                    description = value;
                  },
                )),
            // ListTile(
            //     title: Text("Date"),
            //     subtitle: TextFormField(
            //       keyboardType: TextInputType.datetime,
            //       decoration:
            //           InputDecoration(hintText: "insert date year/month/day"),
            //       validator: (value) {
            //         if (!value.trim().isEmpty) {
            //           if (!isDate(value)) {
            //             return "Invalid date.";
            //           }
            //         } else {
            //           return "Empty date.";
            //         }
            //       },
            //       onSaved: (value) {
            //         date = value;
            //       },
            //     )),
            // ListTile(
            //     title: Text("Date"),
            //     subtitle: DateTimeField(
            //       mode: DateFieldPickerMode.date,
            //       selectedDate: date,
            //       onDateSelected: (DateTime _date) {
            //         setState(() {
            //           date = _date;
            //         });
            //       },
            //       firstDate: now,
            //     )),
            // ListTile(
            //     title: Text("Time"),
            //     subtitle: DateTimeField(
            //       mode: DateFieldPickerMode.time,
            //       selectedDate: time,
            //       onDateSelected: (DateTime _time) {
            //         setState(() {
            //           time = _time;
            //         });
            //       },
            //       firstDate: now,
            //     )),

            ListTile(
              title: Text("Date"),
              subtitle: date == null
                  ? Text("insert date")
                  : Text("${date.year}-${date.month}-${date.day}"),
              onTap: () {
                showDatePicker(
                  initialEntryMode: DatePickerEntryMode.input,
                  context: context,
                  initialDate:
                      date == null ? now : date, //começa a data do dia atual
                  firstDate: now,
                  lastDate: DateTime(now.year + 10),
                ).then((_date) {
                  setState(() {
                    date = _date != null ? _date : date;
                    date = date != null ? date : null;
                  });
                });
              },
            ),
            ListTile(
              title: Text("Time"),
              subtitle: time == null
                  ? Text("insert time")
                  : Text("${time.hour}:${time.minute}"),
              onTap: () {
                showTimePicker(
                        context: context,
                        initialTime: time == null ? TimeOfDay.now() : time)
                    .then((_time) {
                  setState(() {
                    time = _time != null ? _time : time;
                    time = time != null ? time : null;
                  });
                });
              },
            ),
            // ListTile(
            //     title: Text("Time"),
            //     subtitle: TextFormField(
            //       decoration: InputDecoration(hintText: "insert time"),
            //       validator: (value) {
            //         if (!value.trim().isEmpty) {
            //           if (!isTime(value)) {
            //             return "Invalid time with date.";
            //           }
            //         } else {
            //           return "Empty time.";
            //         }
            //       },
            //       onSaved: (value) {
            //         time = value;
            //       },
            //     )),
            ListTile(
                title: Text("Location"),
                subtitle: TextFormField(
                  decoration: InputDecoration(hintText: "insert location"),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Empty location";
                    }
                  },
                  onSaved: (value) {
                    location = value;
                  },
                )),
            ListTile(
                title: Text("Lotation"),
                subtitle: TextFormField(
                  decoration: InputDecoration(hintText: "insert lotation"),
                  validator: (value) {
                    if (!value.trim().isEmpty) {
                      if (!isIntNumber(value)) {
                        return "Invalid lotation value.";
                      }
                    } else {
                      return "Empty lotation.";
                    }
                  },
                  onSaved: (value) {
                    lotation = int.parse(value);
                  },
                )),
            RaisedButton(
              child: Text("Criar"),
              onPressed: () {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();

                  if (date == null || time == null) {
                    // Fluttertoast.showToast(
                    //     msg: "Date and Time must be picked.",
                    //     textColor: Colors.black);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text("A date ant time must be picked."));
                        });
                  } else {
                    //create event
                    event = Event(name, description, date, time, image,
                        widget.user, listGoing, location, rating, lotation);

                    //print(event.name + event.description);
                    //assign event to the creator
                    widget.user.addCreatedEvent(event);
                  }
                  formKey.currentState.reset();
                  //setState(() {});

                  //!guardar na base de dados estas cenas: Evento novo e mais um elemento na lista de eventos criados pelo user (talvez guardar a lista toda denovo)
                  //!ir para outro ecrã depois de ser aceite, HomePage ou ecrã do evento criado???
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
    return true;
  }

  bool isTime(value) {
    //ver se as horas sao possiveis consoante o dia colocado anteriormente
    //levar em consideração as horas atuais para quando a data é referente ao próprio dia
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
