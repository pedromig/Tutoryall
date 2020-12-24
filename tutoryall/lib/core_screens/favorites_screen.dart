import 'package:flutter/material.dart';
import 'package:tutoryall/utils/database.dart';
import 'package:tutoryall/utils/tutoryall_event.dart';
import 'package:tutoryall/utils/tutoryall_user.dart';
import 'package:tutoryall/utils/user_tile.dart';

class FavoritesScreen extends StatefulWidget {
  final String userID;
  FavoritesScreen(this.userID);
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  Future<List<TutoryallUser>> getFavUsers() async {
    TutoryallUser user = await Database.getUser(widget.userID);
    List<TutoryallUser> users = await Database.getUserList();
    List<TutoryallUser> filteredUsers = [];
    for (final u in users) {
      if (user.favUsersIDs.contains(u.id)) {
        filteredUsers.add(u);
      }
    }
    return filteredUsers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Color(0xff7ceccc),
        title: Text(
          "Favorites",
          style: TextStyle(
              fontSize: 25,
              fontFamily: 'Minimo',
              fontWeight: FontWeight.w800,
              color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return FavoritesScreen(widget.userID);
                  },
                  transitionDuration: Duration(seconds: 0),
                ),
              );
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: getFavUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(child: Text("Loading"));
          } else if (snapshot.data.length == 0) {
            return Center(child: Text("No Users to Display"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(child: UserTile(snapshot, index));
              },
            );
          }
        },
      ),
    );
  }
}
