import 'package:flutter/material.dart';

import 'about_us.dart';
import 'report_error.dart';
import 'settings.dart';

class LeftDrawer extends StatefulWidget {
  @override
  _LeftDrawerState createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  @override
  Widget build(BuildContext context) {
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
