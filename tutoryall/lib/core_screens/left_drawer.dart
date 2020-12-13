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

import '../left_drawer_screens/profile_screens/profile.dart';
import '../left_drawer_screens/settings.dart';
import '../left_drawer_screens/about_us.dart';
import '../left_drawer_screens/report_error.dart';
import '../left_drawer_screens/suggestions.dart';
import '../left_drawer_screens/logout.dart';

class LeftDrawer extends StatefulWidget {
  @override
  _LeftDrawerState createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<String> names = [
    "Profile",
    "Settings",
    "About Us",
    "Report Bugs",
    "Suggestions",
    "Logout",
  ];

  final List<IconData> icons = [
    Icons.person,
    Icons.settings_outlined,
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
            builder: (context) => Profile(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Settings(),
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

  _updateDisplayName() async {
    await _auth.currentUser.reload();
    return _auth.currentUser.displayName;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white),
            child: FutureBuilder(
              future: _updateDisplayName(),
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
                color: Colors.white),
            child: Text(" " + _auth.currentUser.email + " ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Minimo',
                  fontWeight: FontWeight.w600,
                )),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.black,
            backgroundImage: NetworkImage(
                "https://steemitimages.com/DQmbaP5UJu7MYwAZFQgmHjgK7d5syHxdFuJvZt9UQKjVGS1/smile1.jpg"),
          ),
          decoration: BoxDecoration(
            color: Color(0xff7ceccc),
            image: DecorationImage(
              image: NetworkImage(
                  "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F6%2F2019%2F12%2Fempire-strikes-back-1-2000.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Divider(
          thickness: 2,
        ),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(icons[index]),
              title: Text(names[index]),
              onTap: () {
                _selectTab(index);
              },
            );
          },
        ),
      ],
    );
  }
}
