/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Miguel André Lourenço Rabuge
 *   
*/
import 'package:flutter/material.dart';

import 'profile_info.dart';
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

  Widget selectTab(int index) {
    switch (index) {
      case 0:
        return Profile();
      case 1:
        return Settings();
      case 2:
        return AboutUs();
      case 3:
        return ReportError();
      case 4:
        return Suggestion();
      case 5:
        return Logout(); //TODO dummy
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        // padding: EdgeInsets.zero,
        UserAccountsDrawerHeader(
          accountName: Text(
            "Miguel",
            style: TextStyle(color: Colors.black),
          ),
          accountEmail: Text("miguelrabuge12@gmail.com",
              style: TextStyle(color: Colors.black)),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.black,
            backgroundImage: NetworkImage(
                "https://thumbor.granitemedia.com/img/o0nPv1FPsHfn_Txo9tZ8NfAyIrw=/800x0/filters:format(webp):quality(80)/granite-web-prod/c6/4c/c64c62fe2b4e462fbe81589075036db4.jpg"),
          ),
          decoration: BoxDecoration(
            color: Color(0xff7ceccc),
            image: DecorationImage(
              image: AssetImage('assets/images/text.png'),
              fit: BoxFit.contain,
            ),
          ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => selectTab(index),
                    ),
                  );
                },
              );
            }),
      ],
    );
  }
}
