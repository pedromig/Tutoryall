/*
import 'package:flutter/material.dart';
import 'event_screen.dart'; //para ter acesso à classe Event

class EditEventScreen extends StatefulWidget {
  User user;
  Event event;

  EditEventScreen(this.user,
      this.event); //para ter acesso ao user dentro do _CreateEventScreenState

  @override
  _EditEventScreenState createState() {
    return _EditEventScreenState();
  }
}

class _EditEventScreenState extends State<EditEventScreen> {
  String name;
  String description;
  String date;
  Image image;
  String location;
  double rating = 0; //pelo que percebi, vai ser calculado posteriormente
  int lotation;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit event"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: "${widget.event.name}"),
              validator: (value) {
                //!aceitar nomes com números? parece-me correto, não sei se é correto restringir nomes
                if (!value.trim().isEmpty) {
                  name = value;
                } else {
                  name = widget.event.name;
                }
              },
            ),
            TextFormField(
              decoration:
                  InputDecoration(hintText: "${widget.event.description}"),
              validator: (value) {
                //!talvez aceitar mesmo quando a descrição está vazia???
                if (!value.trim().isEmpty) {
                  description = value;
                } else {
                  description = widget.event.description;
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "${widget.event.date}"),
              validator: (value) {
                if (!value.trim().isEmpty) {
                  if (isDate(value)) {
                    date = value;
                  } else {
                    return "Invalid date.";
                  }
                } else {
                  date = widget.event.date;
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "${widget.event.location}"),
              validator: (value) {
                if (!value.trim().isEmpty) {
                  location = value;
                } else {
                  location = widget.event.location;
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "${widget.event.lotation}"),
              validator: (value) {
                if (!value.trim().isEmpty) {
                  if (isIntNumber(value)) {
                    lotation = int.parse(value);
                    //return "Lotation value accepted.";
                  } else {
                    return "Invalid lotation value.";
                  }
                } else {
                  lotation = widget.event.lotation;
                }
              },
            ),
            RaisedButton(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  //guardar os novos valores
                  widget.event.name = name;
                  widget.event.description = description;
                  widget.event.date = date;
                  widget.event.location = location;
                  widget.event.lotation = lotation;
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
  bool isEmail(String mail) {
    return true;
  }

  //TODO completar isto
  bool isDate(String date) {
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
*/

import 'package:flutter/material.dart';
import 'package:tutoryall/utils/event.dart';
import 'package:tutoryall/utils/tutoryall_user.dart';

import 'event_screen.dart'; //para ter acesso à classe Event

class EditEventScreen extends StatefulWidget {
  TutoryallUser user;
  Event event;

  EditEventScreen(this.user,
      this.event); //para ter acesso ao user dentro do _CreateEventScreenState

  @override
  _EditEventScreenState createState() {
    return _EditEventScreenState();
  }
}

class _EditEventScreenState extends State<EditEventScreen> {
  String name;
  String description;
  DateTime date;
  TimeOfDay time;
  Image image;
  String location;
  double rating = 0; //pelo que percebi, vai ser calculado posteriormente
  int lotation;

  DateTime now = DateTime.now();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    date = widget.event.date;
    time = widget.event.time;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit event"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            ListTile(
                title: Text("Name"),
                subtitle: TextFormField(
                  decoration: InputDecoration(hintText: "${widget.event.name}"),
                  initialValue: '',
                  validator:
                      (value) {}, //!aceitar nomes com números? parece-me correto, não sei se é correto restringir nomes
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
                  validator:
                      (value) {}, //!talvez aceitar mesmo quando a descrição está vazia???
                  onSaved: (value) {
                    if (!value.trim().isEmpty) {
                      widget.event.description = value;
                    }
                  },
                )),
            // ListTile(
            //     title: Text("Date"),
            //     subtitle: TextFormField(
            //       keyboardType: TextInputType.datetime,
            //       decoration: InputDecoration(hintText: "${widget.event.date}"),
            //       initialValue: '',
            //       validator: (value) {
            //         if (!value.trim().isEmpty && !isDate(value)) {
            //           return "Invalid date.";
            //         }
            //       },
            //       onSaved: (value) {
            //         if (!value.trim().isEmpty && isDate(value)) {
            //           //widget.event.date = value;
            //         }
            //       },
            //     )),
            ListTile(
              title: Text("Date"),
              subtitle: Text("${date.year}-${date.month}-${date.day}"),
              onTap: () {
                showDatePicker(
                  initialEntryMode: DatePickerEntryMode.input,
                  context: context,
                  initialDate: date = widget
                      .event.date, //começa na data previamente selecionada
                  firstDate: now,
                  lastDate: DateTime(now.year + 10),
                ).then((_date) {
                  setState(() {
                    date = _date != null
                        ? _date
                        : date; //se selecionar uma data, fica essa, caso contrário continua a mesma
                    //date = date != null ? date : null;
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
                )),
            RaisedButton(
              child: Text("Guardar"),
              onPressed: () {
                if (formKey.currentState.validate()) {
                  //guardar os novos valores
                  //widget.event.name = name;
                  formKey.currentState.save();
                  widget.event.date = date;
                  widget.event.time = time;
                  formKey.currentState.reset();
                  //setState(() {}); //usei para dar update da info que aparece no ecrã -> para correr o builder outra vez
                  //quando for na app mesmo, não é necessário porque o user vai ser redirecionado para outro ecra
                  // widget.event.description = description;
                  // widget.event.date = date;
                  // widget.event.location = location;
                  // widget.event.lotation = lotation;
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
