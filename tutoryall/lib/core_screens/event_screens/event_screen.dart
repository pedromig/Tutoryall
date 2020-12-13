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
        centerTitle:true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Color(0xff7ceccc),
        title:FittedBox(
          fit: BoxFit.fitWidth, 
          child: Text(
          widget.event.name,
          style: TextStyle(
              fontSize: 25,
              fontFamily: 'Minimo',
              fontWeight: FontWeight.w600,
              color: Colors.black),
          ),
        ),
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
                      "${widget.event.listGoingIDs.length}/${widget.event.lotation}")),
          Container(
              child: Center(
                  child: Text(
            "${widget.event.location}\n${widget.event.date.day}/${widget.event.date.month}/${widget.event.date.year}\n${widget.event.time.hour}h${widget.event.time.minute}m",
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
}