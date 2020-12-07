/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Miguel André Lourenço Rabuge
 *   
*/

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Logout extends StatefulWidget {
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: Color(0xfff2f3f5),
            title: Center(
                  child: AutoSizeText('Logout'),
                ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Center(child: AutoSizeText('Do you wish to logout?')),
                  SizedBox(
                    height: 10,
                  ),

                  RaisedButton(
                    color: Color(0xffed2a18),
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0)),
                    child: AutoSizeText('Logout', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  
                  RaisedButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0)),
                    child:  AutoSizeText('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
        
            ],
          );
  }
}
