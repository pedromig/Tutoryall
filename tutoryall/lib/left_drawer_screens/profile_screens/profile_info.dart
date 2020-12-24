import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutoryall/left_drawer_screens/profile_screens/profile_events.dart';
import 'package:tutoryall/utils/database.dart';
import 'package:tutoryall/utils/tutoryall_user.dart';

class _Dialog extends StatefulWidget {
  final TutoryallUser user;
  _Dialog(this.user);
  @override
  __DialogState createState() => __DialogState();
}

class __DialogState extends State<_Dialog> {
  double _value = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Center(
                child: Text('Rating',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            Icon(Icons.star, size: 100, color: Colors.yellow),
            widget.user.id == Database.authenticatedUser().uid
                ? Center(child: Text("Your rating is ${widget.user.rating.toStringAsFixed(1)}"))
                : ListBody(
                    children: [
                      Slider(
                        value: _value,
                        min: 0,
                        max: 5,
                        divisions: 50,
                        label: _value.toStringAsFixed(1),
                        onChanged: (double value) {
                          setState(() {
                            _value = value;
                          });
                        },
                      ),
                      RaisedButton(
                        color: Color(0xff82E3C4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context, _value);
                        },
                        child: Text('Rate!'),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

class ProfileInfo extends StatefulWidget {
  final TutoryallUser user;
  ProfileInfo(this.user);

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {

  void _getRating() async {
    final double rate = await showDialog(
        context: context,
        builder: (BuildContext context) => _Dialog(widget.user));
    if (rate != null) {
      await Database.updateUserRating(widget.user.id, rate);
      widget.user.rating = (await Database.getUser(widget.user.id)).rating;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
            future: Database.getUserBackgroundImage(widget.user.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: snapshot.data,
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    child: Container(
                      alignment: Alignment(-0.95, 2.1),
                      child: FutureBuilder(
                        future: Database.getUserProfilePicture(widget.user.id),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return CircleAvatar(
                              backgroundImage: snapshot.data,
                              radius: 50.0,
                              backgroundColor: Colors.black,
                            );
                          } else {
                            return CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Colors.black,
                              backgroundImage:
                                  Image.asset("assets/images/default_user.png")
                                      .image,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                );
              } else {
                return Text("Loading...");
              }
            },
          ),
          Container(
            child: Text(
              widget.user.name,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            width: double.infinity,
          ),
          Container(
            child: Text(
              "${widget.user.location}, ${widget.user.age == -1 ? "Age" : widget.user.age}",
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
                      Expanded(
                          flex: 20, child: Center(child: Icon(Icons.mail))),
                      Expanded(
                          flex: 100,
                          child: Center(
                              child: SelectableText(" ${widget.user.contact}")))
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xff82E3C4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                SizedBox(width: screenW * 0.05),
                Container(
                  child: Expanded(
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                      color: Color(0xff82E3C4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                          ),
                          Expanded(
                              child:
                                  Text(widget.user.rating.toStringAsFixed(1)))
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPressed: _getRating,
                    ),
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
                  ),
                ),
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
                    Text("Check Featured Events",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Minimo',
                            fontWeight: FontWeight.w800,
                            color: Colors.black)),
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
                  MaterialPageRoute(
                      builder: (context) => ProfileEvent(widget.user.id)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
