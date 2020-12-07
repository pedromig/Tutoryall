/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Miguel André Lourenço Rabuge
 *   
*/
import 'package:flutter/material.dart';

import 'about_us.dart';
import 'report_error.dart';
import 'settings.dart';

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
  ];

  final List<IconData> icons = [
    Icons.person,
    Icons.settings_outlined,
    Icons.help_outline,
    Icons.bug_report_outlined,
    Icons.help_outline
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: 5,
        padding: EdgeInsets.zero,
        separatorBuilder: (BuildContext context, int index) => Divider(
              thickness: 2,
            ),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(icons[index]),
            title: Text(names[index]),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => {
                    switch(index){
                      case 0:
                        return Profile();
                      case 1:
                        return Settings();
                      case 2:
                        return 
                      case 3:
                        return 
                      case 4:
                        return 
                    },
                  },
                ),
              ),
            },
          );
        }
        // children: <Widget>[
        //   DrawerHeader(
        //     child: Text('Drawer Header'),
        //     decoration: BoxDecoration(
        //       color: Color(0xff7ceccc),
        //     ),
        //   ),
        //   ListTile(
        //     leading: Icon(Icons.person),
        //     title: Text('Profile'),
        //     onTap: () {
        //       // Update the state of the app.
        //       // ...
        //     },
        //   ),
        //   ListTile(
        //     leading: Icon(Icons.settings_outlined),
        //     title: Text('Settings'),
        //     onTap: () {
        //       // Update the state of the app.
        //       // ...
        //     },
        //   ),
        //   ListTile(
        //     leading: Icon(Icons.help_outline),
        //     title: Text('About Us'),
        //     onTap: () {
        //       // Update the state of the app.
        //       // ...
        //     },
        //   ),
        //   ListTile(
        //     leading: Icon(Icons.bug_report_outlined),
        //     title: Text("Reportar Erros"),
        //     onTap: () {
        //       // Update the state of the app.
        //       // ...
        //     },
        //   ),
        // ],
        );

    return Scaffold(
      appBar: AppBar(
        title: Text("Suporte"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              child: OutlineButton.icon(
                icon: Icon(Icons.settings_outlined),
                label: Text("Definições"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings()),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: OutlineButton.icon(
                icon: Icon(Icons.help_outline),
                label: Text("Sobre Nós"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUs()),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: OutlineButton.icon(
                icon: Icon(Icons.bug_report_outlined),
                label: Text("Reportar Erros"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReportError()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
