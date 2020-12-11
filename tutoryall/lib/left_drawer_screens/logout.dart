import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Miguel André Lourenço Rabuge
 *   
*/

import 'package:flutter/material.dart';
import 'package:tutoryall/core_screens/welcome_screen.dart';

class Logout extends StatefulWidget {
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: Color(0xfff2f3f5),
      title: Center(
        child: Text('Logout'),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Center(child: Text('Do you wish to logout?')),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              color: Color(0xffed2a18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              child: Text('Logout', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await _auth.signOut();
                Navigator.pop(context); // Pop Logout AlertDialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ),
                );
              },
            ),
            RaisedButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
