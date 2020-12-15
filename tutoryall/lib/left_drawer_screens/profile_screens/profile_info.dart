import 'package:auto_size_text/auto_size_text.dart';
/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Duarte Manuel Bento Dias
 *   
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutoryall/left_drawer_screens/profile_screens/profile_events.dart';
import 'package:tutoryall/utils/tutoryall_user.dart';

class ProfileInfo extends StatefulWidget {
  final TutoryallUser user;
  ProfileInfo(this.user);

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  bool isFav = true;
  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
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
            child: Text(
              widget.user.name,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            width: double.infinity,
          ),
          Container(
            child: Text(
              "${widget.user.location}, ${widget.user.age == -1? "Age" : widget.user.age}",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            width: double.infinity,
          ),
          Divider(),
          Container(
            child: Row(
              children: [
                SizedBox(width: screenW * 0.05),
                Container(
                  width: screenW * 0.65,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex:20,child:Center(child:Icon(Icons.mail))),
                      Expanded(flex:100,child:Center(child:SelectableText(" ${widget.user.contact}")))
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff82E3C4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(width: screenW * 0.05),
                Container(
                  width: screenW * 0.20,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text("${widget.user.rating}")
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff82E3C4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              SizedBox(width: screenW * 0.05),
              ],
            ),
          ),
          Divider(),
          InkWell(
            child: Container(
              child: Text(
                "${widget.user.bio}",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
                overflow: TextOverflow.fade,
              ),
              padding: EdgeInsets.all(10),
              width: double.infinity,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => new AlertDialog(
                    title: new Text("Bio"),
                    content: SingleChildScrollView(
                      child: new Text(
                        "${widget.user.bio}",
                      ),
                    )),
              );
            },
          ),
          Divider(),
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
