/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Miguel André Lourenço Rabuge
 *   
*/
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'profile.dart';
import 'settings.dart';
import 'about_us.dart';
import 'report_error.dart';
import 'suggestions.dart';
import 'logout.dart';

class LeftDrawer extends StatefulWidget {
  @override
  _LeftDrawerState createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  final List<String> names = [
    "Profile",
    "Settings",
    "About Us",
    "Report Bugs",
    "Sugestions",
    "Logout",
  ];

  final List<IconData> icons = [
    Icons.person,
    Icons.settings_outlined,
    Icons.help_outline,
    Icons.bug_report_outlined,
    Icons.help_outline,
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        // padding: EdgeInsets.zero,
        UserAccountsDrawerHeader(
          accountName: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white),
            child: Text(
              " Miguel Rabuge ",
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
                color: Colors.white),
            child: Text(" miguelrabuge12@gmail.com ",
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
                "https://thumbor.granitemedia.com/img/o0nPv1FPsHfn_Txo9tZ8NfAyIrw=/800x0/filters:format(webp):quality(80)/granite-web-prod/c6/4c/c64c62fe2b4e462fbe81589075036db4.jpg"),
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
          // separatorBuilder: (BuildContext context, int index) => Divider(thickness: 2,), // +ara isto funcionar tem de ser ListView.separator
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
