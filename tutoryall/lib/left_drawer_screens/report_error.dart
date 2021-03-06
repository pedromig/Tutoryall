import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ReportError extends StatefulWidget {
  @override
  _ReportErrorState createState() => _ReportErrorState();
}

class _ReportErrorState extends State<ReportError> {
  @override
  Widget build(BuildContext context) {
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Color(0xff7ceccc),
        title: Text("Report Bugs", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: screenH * 0.2,
            ),
            Container(
              height: screenH * 0.35,
              child: AutoSizeText(
                "A tua ajuda é muito importante!\n\n" +
                    "Caso encontres algum bug, carrega no botão abaixo!",
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
                onPressed: _sendBugReport,
                child: Text('Reportar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendBugReport() async {
    final Email email = Email(
      body:
          '<B>Report</B><br><br><u>What Happened:</u><br><br><u>Where:</u><br><br><u>Short guide to reproduce the error:</u><br><br><br>(Feel free to attach any screenshots)<br><br>Thank you!<br><br> - <u>Tutory\'all Development Team</u><br>',
      subject: '[ERROR REPORT]',
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
