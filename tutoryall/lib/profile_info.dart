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
import 'package:tutoryall/profile_events.dart';

final List<String> entries = <String>['A', 'B', 'C'];
final List<int> colorCodes = <int>[600, 500, 100];

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  bool isFav = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  backgroundColor: Color(0xff03f4fc),
                ),
              ),
            ),
          ),
          Container(
              width: double.infinity,
              height: 50,
              child: InkWell(
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
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xff82E3C4)),
                ),
                onTap: () {
                  setState(() {
                    isFav = !isFav;
                    //TODO: change here
                  });
                },
              ),
              alignment: Alignment(0.7, 0)),
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
              height: 200,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => new AlertDialog(
                    title: new Text("Bio"),
                    content: SingleChildScrollView(
                      child: new Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
                      ),
                    )),
              );
            },
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.mail),
                        Text("notanemail@gmail.com")
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff82E3C4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.red,
                        ),
                        Text("4.89")
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff82E3C4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Check Featured Events"),
                    Icon(Icons.arrow_forward),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(
                        0.9, 0.0), // 10% of the width, so there are ten blinds.
                    colors: [const Color(0xff82E3C4), const Color(0xff03f4fc)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileEvent()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
