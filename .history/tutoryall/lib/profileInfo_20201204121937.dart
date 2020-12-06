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
                          "https://tmssl.akamaized.net/images/portrait/header/283130-1542106491.png?lm=1542106523"),
                      fit: BoxFit.cover)),
              child: Container(
                width: double.infinity,
                height: 200,
                child: Container(
                  alignment: Alignment(-1.0, 1.5),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://tmssl.akamaized.net/images/portrait/header/283130-1542106491.png?lm=1542106523"),
                    radius: 60.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
