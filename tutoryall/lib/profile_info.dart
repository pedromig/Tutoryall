/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Duarte Manuel Bento Dias
 *   
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutoryall/tile.dart';

final List<String> entries = <String>['A', 'B', 'C'];
final List<int> colorCodes = <int>[600, 500, 100];

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
  }

  bool isFav = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
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
              child: Container(
                alignment: Alignment(-1.0, 2.5),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://tmssl.akamaized.net/images/portrait/header/283130-1542106491.png?lm=1542106523"),
                  radius: 50.0,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),
          InkWell(
            child: Container(
                width: double.infinity,
                height: 50,
                child: Container(
                  width: 40,
                  height: 40,
                  child: isFav == true
                      ? Icon(
                          Icons.favorite,
                          size: 30,
                          color: Colors.red[800],
                        )
                      : Icon(Icons.favorite_border, size: 30),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                ),
                alignment: Alignment(0.7, 0)),
            onTap: () {
              setState(() {
                isFav = !isFav;
                //TODO: change here
              });
            },
          ),
          Container(
            child: Text(
              "God Marega",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
            ),
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            width: double.infinity,
          ),
          Container(
            child: Text(
              "Amadora, 28",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.left,
            ),
            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
            width: double.infinity,
          ),
          InkWell(
            child: Container(
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
              ),
              padding: EdgeInsets.all(10),
              width: double.infinity,
              height: 100,
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => new AlertDialog(
                        title: new Text("Bio"),
                        content: new Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        ),
                      ));
            },
          ),
          Card(
            child: Row(),
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        color: Colors.blue,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.mail),
                              Text("atuamaeegay@gmail.com")
                            ],
                          ),
                        ))),
                Expanded(
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        color: Colors.blue,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Icon(Icons.star), Text("1.23")],
                          ),
                        ))),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(10),
            child: Text(
              "Featured in",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          /* Expanded(
                child: ListView(
              children: [
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    color: Colors.blue,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Icon(Icons.star), Text("1.23")],
                      ),
                    )),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    color: Colors.blue,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Icon(Icons.star), Text("1.23")],
                      ),
                    )),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    color: Colors.blue,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Icon(Icons.star), Text("1.23")],
                      ),
                    )),
                Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    color: Colors.blue,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Icon(Icons.star), Text("1.23")],
                      ),
                    )),
              ],
            )) */
          Expanded(
            child: Container(
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
          )
        ],
      ),
    );
  }
}

class User {
  final String name;
  final List<Tag> tags;
  User(this.name, this.tags);
}

class Tag {
  final String tagName;

  Tag(this.tagName);
}
