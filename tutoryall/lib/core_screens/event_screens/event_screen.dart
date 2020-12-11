import 'package:flutter/material.dart';
import 'package:tutoryall/utils/event.dart';
import 'package:tutoryall/utils/tutoryall_user.dart';


class EventScreen extends StatefulWidget {
  final Event event; //store event object

  //receives a event object
  EventScreen(this.event);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  bool ir = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.name),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://cdn.record.pt/images/2019-03/img_920x518\$2019_03_06_21_25_15_1514388.jpg"),
                    fit: BoxFit.cover)),
            child: Container(
              width: double.infinity,
              height: 150,
              child: GestureDetector(
                  onTap: () {
                    //à partida dará para ir usando widget.event.creator
                    print("ir para o perfil do user");
                  },
                  child: Container(
                    alignment: Alignment(-1.0, 2.5),
                    //é suposto esta imagem ser a do criador do evento
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://tmssl.akamaized.net/images/portrait/header/283130-1542106491.png?lm=1542106523"),
                      radius: 50.0,
                      backgroundColor: Colors.white,
                    ),
                  )),
            ),
          ),
          ListTile(
              title: Text(
                "Go to event",
                textAlign: TextAlign.center,
              ),
              trailing: IconButton(
                icon: ir == false ? Icon(Icons.check) : Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    ir = !ir;
                  });
                },
              )),
          ListTile(
              title: Text(
                "Rating",
              ),
              trailing: Text("${widget.event.rating}")),
          ListTile(
              title: Text(
                "Lotation",
              ),
              trailing: //Text("${widget.event.listGoing.length}/${widget.event.lotation}")),
                  Text(
                      "${createListUsers(10).length}/${widget.event.lotation}")),
          Container(
              child: Center(
                  child: Text(
            "${widget.event.location}\n${widget.event.date.year}/${widget.event.date.month}/${widget.event.date.day}\n${widget.event.time.hour}h: ${widget.event.time.minute}m",
            textAlign: TextAlign.center,
          ))),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
            child: Text(
              widget.event.description,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  List<TutoryallUser> createListUsers(int n) {
    List<TutoryallUser> l = [];
    for (int i = 0; i < n; i++) {
      // User(this.name, this.age, this.contact, this.bio, this.createdEvents, this.goingEvents, this.image);
      TutoryallUser x = TutoryallUser("name$i", null, i, "$i@boda.com",
          "Eu sou o name$i, gosto desta app.", null);
      l.add(x);
    }
    return l;
  }
}

//TODO verificar se determinado evento esta na lista do user para saber que icon colocar (check ou xCross)
//? Vão haver vários objetos com a mesma informação, ou vai haver apenas um objeto e depois vários pointers para o mesmo objeto na base de dados
