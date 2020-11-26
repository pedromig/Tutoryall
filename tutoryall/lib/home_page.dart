import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'tile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      home: MyHomePage('Tutory\'all'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String title;

  MyHomePage(title) {
    this.title = title;
  }

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  //Function to read the info from the json file
  Future<List<User>> _getData() async {
    List<User> users = [];
    User x;
    List<Tag> tags = [];
    Tag y;

    for (var i = 0; i < 20; i++) {
      for (var e = 0; e < 10; e++) {
        y = Tag("tag $e");
        tags.add(y);
      }
      x = User("Gabriel $i", tags);
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
        title: Text(widget.title),
        backgroundColor: Colors.blue[200],
      ),
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.blue[200],
          child: Container(
              height: 20,
              /*child: Align(
                  alignment: Alignment.center, child: Text("bottom da app"))*/
              child: Row(
                children: <Widget>[
                  ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width / 3),
                      child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: IconButton(
                            icon: Icon(Icons.favorite),
                            onPressed: () {
                              print(
                                  "botão random que coloquei para serem três");
                            },
                          ))),
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
                          ))),
                  ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: MediaQuery.of(context).size.width / 3),
                      child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: IconButton(
                            icon: Icon(Icons.settings),
                            onPressed: () {
                              print("Botão de settings");
                            }, //colocar o que fazer quando o icon for premido
                          )))
                ],
              ))),
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

//TODO implementar esta classe corretamente para suprimir as necessidades da aplicação
//      Mudar o nome desta classe para Event
//      Ter de ter um User associado ao evento
//      Criar a classe User com todos os dados de user
class User {
  final String name;
  final List<Tag> tags;
  User(this.name, this.tags);
}

class Tag {
  final String tagName;

  Tag(this.tagName);
}
