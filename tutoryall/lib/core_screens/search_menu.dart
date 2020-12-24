/** * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Miguel André Lourenço Rabuge
 *   
*/

import 'package:flutter/material.dart';
import 'package:tutoryall/utils/custom_tile.dart';
import 'package:tutoryall/utils/database.dart';
import 'package:tutoryall/utils/tutoryall_event.dart';
import 'event_screens/create_event_screen.dart';
import 'home_page.dart';

class SearchMenu extends StatefulWidget {
  @override
  _SearchMenuState createState() => _SearchMenuState();
}

class _SearchMenuState extends State<SearchMenu> {
  final List<String> searchTags = [];

  Future<List<TutoryallEvent>> _getData() async {
    List<TutoryallEvent> eventList = await Database.getEventList();
    List<TutoryallEvent> filteredEvents = [];
    for (final ev in eventList) {
      for (final t in searchTags) {
        if (ev.tags.contains(t)) {
          filteredEvents.add(ev);
          break;
        }
      }
    }
    return filteredEvents;
  }

  _getChips() {
    List<Widget> widgets = [];

    for (int i = 0; i < searchTags.length; ++i) {
      widgets.add(
        Chip(
          label: Text(searchTags[i]),
          onDeleted: () {
            setState(
              () {
                searchTags.remove(searchTags[i]);
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
                        searchTags.add(_input.text.trim());
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

  Future<List<dynamic>> _getAllTags() async {
    List<dynamic> allTags = [];
    List<TutoryallEvent> events = await Database.getEventList();
    for (final ev in events) {
      ev.tags.forEach((x) {
        allTags.add(x);
      });
    }
    allTags = Set.from(allTags).toList();
    allTags.sort();
    return allTags;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline_outlined),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    title: Text("Available Tags"),
                    content: FutureBuilder(
                      future: _getAllTags(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Text("Loading");
                        } else if (snapshot.data.length == 0) {
                          return Text("No Tags available");
                        } else {
                          return SingleChildScrollView(
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Text(" - ${snapshot.data[index]}");
                              },
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              );
            },
          )
        ],
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Search",
          style: TextStyle(
            fontSize: 35,
            fontFamily: 'Minimo',
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff7ceccc),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Color(0xff7ceccc),
        child: Container(
          child: Row(
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width / 3),
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return HomePage();
                          },
                          transitionDuration: Duration(seconds: 0),
                        ),
                      );
                    },
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width / 3),
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width / 3),
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: IconButton(
                    icon: Icon(Icons.add_circle_outlined),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateEventScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        physics: ScrollPhysics(),
        children: [
          WillPopScope(
            onWillPop: () {
              return Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return HomePage();
                  },
                  transitionDuration: Duration(seconds: 0),
                ),
              );
            },
            child: Container(),
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
          Divider(),
          FutureBuilder(
            future: _getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                      child: Text("Loading"),
                    ));
              } else {
                if (snapshot.data.length != 0) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          child: CustomTile(snapshot, index, "SearchMenu"));
                    },
                  );
                } else {
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Center(
                        child: Text("Add tags to get related Events!"),
                      ));
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
