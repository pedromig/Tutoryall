/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Gabriel Mendes Fernandes
 *   
*/

import 'package:flutter/material.dart';
import 'package:tutoryall/core_screens/favorites_screen.dart';
import 'package:tutoryall/utils/custom_tile.dart';
import 'package:tutoryall/utils/database.dart';
import 'package:tutoryall/utils/tutoryall_event.dart';
import 'package:tutoryall/utils/tutoryall_user.dart';

import 'dart:async';
import 'event_screens/create_event_screen.dart';
import 'search_menu.dart';
import 'left_drawer.dart';
import '../left_drawer_screens/logout.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();
  Future<List<TutoryallEvent>> _futureList;

  Future<List<TutoryallEvent>> _getData() async {
    List<TutoryallEvent> eventList = await Database.getEventList();
    return eventList;
  }

  _newUserDialog() {
    if (Database.authenticatedUser().displayName == null ||
        Database.authenticatedUser().displayName.isEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              backgroundColor: Color(0xfff2f3f5),
              title: Text("Insert your name "),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextField(
                      autofocus: true,
                      onChanged: (value) async {
                        if (value.isEmpty) value = "Anonymous";
                        await Database.authenticatedUser()
                            .updateProfile(displayName: value);
                        Database.newUser(TutoryallUser(
                            Database.authenticatedUser().uid,
                            Database.authenticatedUser().displayName,
                            "City",
                            -1,
                            Database.authenticatedUser().email,
                            "Tell us more about you!",
                            0,
                            null, [], [], []));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      child:
                          Text('Submit', style: TextStyle(color: Colors.black)),
                      onPressed: () async {
                        Navigator.pop(context);
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _futureList = _getData();
    WidgetsBinding.instance.addPostFrameCallback((_) => _newUserDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              icon: Icon(
                Icons.menu_rounded,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () => {Scaffold.of(context).openDrawer()}),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff82E3C4), Color(0xff7ceccc)]),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.pink,
              size: 35.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FavoritesScreen(Database.authenticatedUser().uid)),
              );
            },
          ),
        ],
        title: Text(
          "tutory'all",
          style: TextStyle(
              fontSize: 35,
              fontFamily: 'Minimo',
              fontWeight: FontWeight.w800,
              color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff7ceccc),
      ),
      drawer: Drawer(
        child: LeftDrawer(),
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
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return SearchMenu();
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
      body: WillPopScope(
        onWillPop: () {
          return showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Logout();
            },
          );
        },
        child: Container(
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return HomePage();
                    },
                    transitionDuration: Duration(milliseconds: 0),
                  ),
                );
              });
            },
            child: FutureBuilder(
              future: _futureList,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          child: CustomTile(snapshot, index, "HomeMenu"));
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
