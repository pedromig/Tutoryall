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
                onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(
                                widget.snapshot.data[widget.index].id)),
                      ),
                    },
                leading: CircleAvatar(),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        '${widget.snapshot.data[widget.index].location}, ${widget.snapshot.data[widget.index].age}'),
                    Text("${widget.snapshot.data[widget.index].contact}")
                  ],
                ),
                trailing: Column(
                  children: <Widget>[
                    Expanded(
                      child: Icon(
                        Icons.star,
                        size: 50,
                        color: Colors.yellow,
                      ),
                    ),
                    Expanded(
                        child: Text(
                      widget.snapshot.data[widget.index].rating
                          .toStringAsFixed(1),
                      style: TextStyle(fontSize: 15),
                    )),
                  ],
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
