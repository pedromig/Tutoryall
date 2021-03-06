import 'package:firebase_auth/firebase_auth.dart';
/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Miguel André Lourenço Rabuge
 *   
*/
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tutoryall/utils/database.dart';

import '../left_drawer_screens/profile_screens/profile.dart';
import '../left_drawer_screens/my_events.dart';
import '../left_drawer_screens/about_us.dart';
import '../left_drawer_screens/report_error.dart';
import '../left_drawer_screens/suggestions.dart';
import '../left_drawer_screens/logout.dart';

class LeftDrawer extends StatefulWidget {
  @override
  _LeftDrawerState createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  final List<String> names = [
    "Profile",
    "My Events",
    "About Us",
    "Report Bugs",
    "Suggestions",
    "Logout",
  ];

  final List<IconData> icons = [
    Icons.person,
    Icons.event_note,
    Icons.help_outline,
    Icons.bug_report_outlined,
    Icons.inbox_outlined,
    Icons.power_settings_new_outlined,
  ];

  void _selectTab(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Profile(Database.authenticatedUser().uid, false),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyEvents(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AboutUs(),
          ),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReportError(),
          ),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Suggestion(),
          ),
        );
        break;
      case 5:
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Logout();
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        FutureBuilder(
          future:
              Database.getUserBackgroundImage(Database.authenticatedUser().uid),
          builder: (BuildContext context, AsyncSnapshot drawerSnapshot) {
            if (drawerSnapshot.data != null) {
              return UserAccountsDrawerHeader(
                accountName: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.white),
                  child: FutureBuilder(
                    future: Database.getUserDisplayName(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null || snapshot.data.isEmpty) {
                        return Text(
                          "Loading...",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Minimo',
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        );
                      } else
                        return Text(
                          " " + snapshot.data + " ",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Minimo',
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        );
                    },
                  ),
                ),
                accountEmail: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: Text(
                    " " + Database.authenticatedUser().email + " ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Minimo',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                currentAccountPicture: FutureBuilder(
                  future: Database.getUserProfilePicture(
                      Database.authenticatedUser().uid),
                  builder: (contex, snapshot) {
                    if (snapshot.data != null) {
                      return CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: snapshot.data,
                      );
                    } else {
                      return CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            Image.asset("assets/images/default_user.png").image,
                      );
                    }
                  },
                ),
                decoration: BoxDecoration(
                  color: Color(0xff7ceccc),
                  image: DecorationImage(
                    image: drawerSnapshot.data,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            } else {
              return UserAccountsDrawerHeader(
                accountName: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.white),
                  child: Text(
                    "Loading...",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Minimo',
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                accountEmail: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.white,
                  ),
                  child: Text(
                    " " + Database.authenticatedUser().email + " ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Minimo',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage:
                      Image.asset("assets/images/default_user.png").image,
                ),
                decoration: BoxDecoration(
                  color: Color(0xff7ceccc),
                  image: DecorationImage(
                    image: Image.asset("assets/images/cover_pic.png").image,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }
          },
        ),
        Divider(
          thickness: 2,
        ),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(icons[index]),
              title: Text(
                names[index],
              ),
              onTap: () {
                _selectTab(index);
              },
            );
          },
        ),
        Divider(
          thickness: 1,
        ),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(icons[index + 2]),
              title: Text(
                names[index + 2],
              ),
              onTap: () {
                _selectTab(index + 2);
              },
            );
          },
        ),
      ],
    );
  }
}
