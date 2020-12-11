import 'package:firebase_auth/firebase_auth.dart';
/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Gabriel Mendes Fernandes
 *   
*/

import 'package:flutter/material.dart';
import 'package:tutoryall/utils/custom_tile.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _HomePageState();

  Future<List<TutoryallUser>> _getData() async {
    List<TutoryallUser> users = [];

    List<String> tags = [];
    String y;

    for (var i = 0; i < 20; i++) {
      for (var e = 0; e < 10; e++) {
        y = "tag $e";
        tags.add(y);
      }
      users.add(
        TutoryallUser("Gabriel $i", tags, 10, "924182731", "Lol", null),
      );
    }
    return users;
  }

  _newUserDialog() {
    if (_auth.currentUser.displayName == null ||
        _auth.currentUser.displayName.isEmpty) {
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
              title: Text("Insert your name"),
              content: Row(
                children: <Widget>[
                  Center(
                    child: TextField(
                      autofocus: true,
                      onChanged: (value) {
                        _auth.currentUser.updateProfile(displayName: value);
                      },
                    ),
                  ),
                ],
              ),
              actions: [
                FlatButton(
                  child: Text("Submit"),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
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
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () => {print("Tapped Favorite")},
              child: Icon(
                Icons.favorite,
                color: Colors.pink,
                size: 35.0,
              ),
            ),
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
                        MaterialPageRoute(
                          builder: (context) => SearchMenu(),
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
                          builder: (context) => CreateEventScreen(null),
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
          child: FutureBuilder(
            future: _getData(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading"),
                  ),
                );
              } else {
                return ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomTile(snapshot, index);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 2,
                      thickness: 2,
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}