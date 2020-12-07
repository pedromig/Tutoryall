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
// import 'package:http/http.dart' as http;
// import 'dart:convert';

import 'left_drawer.dart';
import 'tile.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage({Key key, this.user});

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
      print(x.tags.length);
      users.add(x);
    }
    return users;

    /*
    var data = await http.get(); //put the link in here
    var jsonData = json.decode(data.body);
    List<User> users = [];

    for (var i in jsonData) {
      User user = User(i.name);

      users.add(user);
    }

    return users;
    */
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
        title: Image.asset(
          "assets/images/text.png",
          width: 170,
          height: 38,
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
      body: Container(
        child: FutureBuilder(
          future: _getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading")));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  /*return ListTile(
                    title: Text(snapshot.data[index].name),
                    trailing: CircleAvatar(),
                  )
                  ;
                  */
                  return CustomTile(snapshot: snapshot, index: index);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

// TODO:  Passar para um ficheiro .dart caso seja necessário usar esta classe
//TODO implementar esta classe corretamente para suprimir as necessidades da aplicação
//      Mudar o nome desta classe para Event
//      Ter de ter um User associado ao evento
//      Criar a classe User com todos os dados de user
class OurUser {
  final String name;
  final List<Tag> tags;
  OurUser(this.name, this.tags);
}

class Tag {
  final String tagName;

  Tag(this.tagName);
}
