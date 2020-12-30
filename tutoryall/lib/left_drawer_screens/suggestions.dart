import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

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
                onPressed: _sendSuggestion,
                child: Text('Tenho uma ideia!'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendSuggestion() async {
    final Email email = Email(
      body:
          '<B>Suggestion</B><br><br><u>Motive:</u><br><br><u>What\'s on your mind?</u><br><br><br>Thank you!<br><br> - <u>Tutory\'all Development Team</u><br>',
      subject: '[SUGGESTION]',
      recipients: ['tutoryall@gmail.com'],
      isHTML: true,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    print("Email status: " + platformResponse);
  }
}
