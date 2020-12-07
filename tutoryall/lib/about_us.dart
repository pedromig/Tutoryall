import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre Nós"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "\nA nossa startup, Tutory’all, foca-se em ajudar as pessoas a encontrar a ajuda de alguém que está disponível e empolgado por partilhar conhecimento.\n\n" +
                    "O nosso objetivo é começar pelo ambiente escolar agilizando a comunicação entre os alunos.\n",
                style: TextStyle(
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.scaleDown,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 15),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    child: Text("Fixe!"),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                ),
                
              ),
            ]),
      ),
    );
  }
}
