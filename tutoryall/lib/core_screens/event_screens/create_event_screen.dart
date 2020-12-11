import 'package:flutter/material.dart';
import 'package:tutoryall/utils/event.dart';
import 'package:tutoryall/utils/tutoryall_user.dart';


class CreateEventScreen extends StatefulWidget {
  final TutoryallUser user; // se der bosta retirar o final

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
  List<TutoryallUser>
      listGoing; //daqui sai vazia, mais tarde vão ser adicionados
  String location;
  double rating = 0; //pelo que percebi, vai ser calculado posteriormente
  int lotation;

  DateTime now = DateTime.now();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Event",
          style: TextStyle(
              fontSize: 35,
              fontFamily: 'Minimo',
              fontWeight: FontWeight.w800,
              color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff7ceccc),
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
                    return null;
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
                    return null;
                  },
                  onSaved: (value) {
                    description = value;
                  },
                )),
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
            ListTile(
                title: Text("Location"),
                subtitle: TextFormField(
                  decoration: InputDecoration(hintText: "insert location"),
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return "Empty location";
                    }
                    return null;
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
                    if (value.trim().isNotEmpty && !isIntNumber(value)) {
                      return "Invalid lotation value.";
                    } else {
                      return "Empty lotation.";
                    }
                  },
                  onSaved: (value) {
                    lotation = int.parse(value);
                  },
                )),
            RaisedButton(
              color: Color(0xff7ceccc),
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

  //to do: completar isto
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
