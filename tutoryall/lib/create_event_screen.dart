import 'package:flutter/material.dart';
import 'event_screen.dart'; //para ter acesso à classe Event

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
  String date;
  Image image;
  List<User> listGoing = null; //daqui sai vazia, mais tarde vão ser adicionados
  String location;
  double rating = 0; //pelo que percebi, vai ser calculado posteriormente
  int lotation;

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
            TextFormField(
              decoration: InputDecoration(hintText: "Name"),
              validator: (value) {
                //!aceitar nomes com números? parece-me correto, não sei se é correto restringir nomes
                if (value.trim().isEmpty) {
                  return "Invalid name.";
                } else {
                  name = value;
                  //return "Name accepted.";
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Description"),
              validator: (value) {
                //!talvez aceitar mesmo quando a descrição está vazia???
                if (value.trim().isEmpty) {
                  description = value;
                  return "Empty description.";
                } else {
                  //return "Description accepted.";
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Event date"),
              validator: (value) {
                if (isDate(value)) {
                  date = value;
                  //return "Date accepted.";
                } else {
                  return "Invalid date.";
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Location"),
              validator: (value) {
                if (value.trim().isEmpty) {
                  return "Empty location";
                } else {
                  location = value;
                  //return "Location accepted.";
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Lotation"),
              validator: (value) {
                if (isIntNumber(value)) {
                  lotation = int.parse(value);
                  //return "Lotation value accepted.";
                } else {
                  return "Invalid lotation value.";
                }
              },
            ),
            RaisedButton(
              onPressed: () {
                if (formKey.currentState.validate()) {
                  //create event
                  event = Event(name, description, date, image, widget.user,
                      listGoing, location, rating, lotation);
                  //assign event to the creator
                  widget.user.addCreatedEvent(event);

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
