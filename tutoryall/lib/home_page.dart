import 'package:firebase_auth/firebase_auth.dart';
/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Gabriel Mendes Fernandes
 *   
*/

import 'package:flutter/material.dart';
import 'dart:async';

import 'left_drawer.dart';
import 'logout.dart';
import 'tile.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Function to read the info from the json file
  Future<List<OurUser>> _getData() async {
    List<OurUser> users = [];
    OurUser x;
    List<Tag> tags = [];
    Tag y;

    for (var i = 0; i < 20; i++) {
      for (var e = 0; e < 10; e++) {
        y = Tag("tag $e");
        tags.add(y);
      }
      x = OurUser("Gabriel $i", tags);
      users.add(x);
    }
    return users;
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
          )
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
                    onPressed: () {
                      print("botão random que coloquei para serem três");
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
                    onPressed: () {
                      print("Botão de pesquisa");
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
                      print("Botão Adicionar Evento");
                    }, //colocar o que fazer quando o icon for premido
                  ),
                ),
              )
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
                    return CustomTile(snapshot: snapshot, index: index);
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

class OurUser {
  final String name;
  final List<Tag> tags;
  OurUser(this.name, this.tags);
}

class Tag {
  final String tagName;

  Tag(this.tagName);
}
