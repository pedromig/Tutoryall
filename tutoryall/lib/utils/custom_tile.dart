import 'package:flutter/cupertino.dart';
/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Gabriel Mendes Fernandes
 *   
*/

import 'package:flutter/material.dart';
import 'package:tutoryall/core_screens/event_screens/event_screen.dart';
import 'package:tutoryall/utils/database.dart';
import 'package:tutoryall/utils/event.dart';

class CustomTile extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final int index;

  CustomTile(this.snapshot, this.index);

  List<Widget> getTags() {
    List<Widget> tags = [];
    for (int i = 0; i < this.snapshot.data[this.index].tags.length; i++) {
      if (i == 0) {
        tags.add(Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(CupertinoIcons.flame),
            ),
            label: Text(this.snapshot.data[this.index].tags[i])));
      } else {
        tags.add(Chip(label: Text(this.snapshot.data[this.index].tags[i])));
      }
    }
    return tags;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: Colors.red),
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: ListTile(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventScreen(
                      Event(
                        this.snapshot.data[this.index].name,
                        this.snapshot.data[this.index].description,
                        this.snapshot.data[this.index].date,
                        this.snapshot.data[this.index].time,
                        this.snapshot.data[this.index].image,
                        this.snapshot.data[this.index].creatorID,
                        this.snapshot.data[this.index].listGoingIDs,
                        this.snapshot.data[this.index].location,
                        this.snapshot.data[this.index].rating,
                        this.snapshot.data[this.index].lotation,
                        this.snapshot.data[this.index].tags,
                      ),
                    ),
                  ),
                ),
              },
              leading: InkWell(
                onTap: () => {print("Pressed Image")},
                child: CircleAvatar(),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(this.snapshot.data[this.index].name,
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  Text(
                      '${this.snapshot.data[this.index].date.day}/${this.snapshot.data[this.index].date.month}/${this.snapshot.data[this.index].date.year} ${this.snapshot.data[this.index].time.hour}h${this.snapshot.data[this.index].time.minute}'),
                  Text('${this.snapshot.data[this.index].location}'),
                  Text(
                      "${this.snapshot.data[this.index].listGoingIDs.length}/${this.snapshot.data[this.index].lotation} people are going"),
                  Wrap(spacing: 8.0, runSpacing: 1.0, children: getTags()),
                ],
              ),
              trailing: Column(
                children: <Widget>[
                  Expanded(
                    child: Icon(
                      Icons.star,
                      size: 70,
                      color: Colors.yellow,
                    ),
                  ),
                  Expanded(
                    child: Text("4.5"),
                  ),
                ],
              ),
              title: FutureBuilder(
                  future: Database()
                      .getUser(this.snapshot.data[this.index].creatorID),
                  builder: (BuildContext buildContext, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Text("Loading");
                    } else {
                      return Text(
                        snapshot.data.name,
                        style: TextStyle(fontSize: 19),
                      );
                    }
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
