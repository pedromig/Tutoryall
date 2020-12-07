import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutoryall/tile.dart';

class NewPg extends StatefulWidget {
  @override
  _NewPgState createState() => _NewPgState();
}

class _NewPgState extends State<NewPg> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(children: [
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://imgs.smoothradio.com/images/191589?crop=16_9&width=660&relax=1&signature=Rz93ikqcAz7BcX6SKiEC94zJnqo="),
                fit: BoxFit.cover)),
        child: Container(
          width: double.infinity,
          height: 150,
          child: Container(
            alignment: Alignment(-1.0, 2.5),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://www.pcgamesn.com/wp-content/uploads/2018/10/gabe_newell_meme-580x334.jpg"),
              radius: 50.0,
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    ]));
  }
}
