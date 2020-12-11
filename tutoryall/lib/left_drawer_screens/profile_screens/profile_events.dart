import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutoryall/utils/custom_tile.dart';

class ProfileEvent extends StatefulWidget {
  @override
  _ProfileEventState createState() => _ProfileEventState();
}

class _ProfileEventState extends State<ProfileEvent> {
  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Featured Events"),
      ),
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
                  return CustomTile(snapshot, index);
                },
              );
            }
          },
        ),
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
