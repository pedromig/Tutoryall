import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Username"),
        centerTitle: true,
      ),
      drawer: Drawer(),
      body: SafeArea(
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
                  alignment: Alignment(-1.0, 2),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://tmssl.akamaized.net/images/portrait/header/283130-1542106491.png?lm=1542106523"),
                    radius: 50.0,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 20,
            ),
            Container(
              child: Text(
                "\"Life is nothing But a Cruel Mistress\"",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.all(10),
              width: double.infinity,
            ),
            Container(
              child: Card(
                Text(
                  "God Marega",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
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
            )
          ],
        ),
      ),
    );
  }
}
