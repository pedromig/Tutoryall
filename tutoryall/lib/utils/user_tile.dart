import 'package:flutter/material.dart';
import 'package:tutoryall/left_drawer_screens/profile_screens/profile.dart';
import 'package:tutoryall/utils/database.dart';

class UserTile extends StatefulWidget {
  final AsyncSnapshot snapshot;
  final int index;

  UserTile(this.snapshot, this.index);

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: Colors.red),
      ),
      child: Column(
        children: <Widget>[
          Container(
            child: ListTile(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(
                            widget.snapshot.data[widget.index].id, true)),
                  );
                  widget.snapshot.data[widget.index] =
                      await Database.getUser(widget.snapshot.data[widget.index].id);
                  setState(() {});
                },
                leading: FutureBuilder(
                  future: Database.getUserProfilePicture(
                      widget.snapshot.data[widget.index].id),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return CircleAvatar(
                        backgroundImage: snapshot.data,
                      );
                    } else {
                      return CircleAvatar(
                        backgroundImage:
                            Image.asset("assets/images/default_user.png").image,
                      );
                    }
                  },
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        '${widget.snapshot.data[widget.index].location}, ${widget.snapshot.data[widget.index].age == -1 ? "Age" : widget.snapshot.data[widget.index].age}'),
                    Text("${widget.snapshot.data[widget.index].contact}")
                  ],
                ),
                trailing: Container(
                  child: Center(
                    widthFactor: 0.8,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.star,
                            size: 60,
                            color: Colors.yellow,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              widget.snapshot.data[widget.index].rating
                                  .toStringAsFixed(1),
                              style: TextStyle(fontSize: 15),
                            )),
                      ],
                    ),
                  ),
                ),
                title: Text(
                  widget.snapshot.data[widget.index].name,
                  style: TextStyle(fontSize: 19),
                )),
          ),
        ],
      ),
    );
  }
}
