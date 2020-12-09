import 'package:auto_size_text/auto_size_text.dart';
/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Miguel André Lourenço Rabuge
 *   
*/

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Suggestion extends StatefulWidget {
  @override
  _SuggestionState createState() => _SuggestionState();
}

class _SuggestionState extends State<Suggestion> {
  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Color(0xff7ceccc),
        title: Text("Suggestions", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: screenH * 0.2,
            ),
            Container(
              width: screenW * 0.9,
              height: screenH * 0.35,
              child: AutoSizeText(
                "Tu também fazes parte do Universo Tutory\'all\n\n" +
                    "Caso tenhas alguma ideia que queiras ver na aplicação, diz-nos!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Minimo',
                    fontWeight: FontWeight.w600),
              ),
            ),
            Center(
              child: RaisedButton(
                color: Color(0xff7ceccc),
                onPressed: () => _launchURL(
                    'miguelrabuge12@gmail.com',
                    '[SUGGESTION]',
                    '<B>Suggestion</B><br><br><u>Motive:</u><br><br><u>What\'s on your mind?</u><br><br><br>Thank you!<br><br> - <u>Tutory\'all Development Team</u><br>'),
                child: Text('Tenho uma ideia!'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
      print("enviou!!!!");
    } else {
      throw 'Could not launch $url';
    }
  }
}
