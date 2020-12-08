/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Miguel André Lourenço Rabuge
 *   
*/

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: screenW * 0.9,
                height: screenH * 0.4,
                child: AutoSizeText(
                  "\nA nossa startup, Tutory’all, foca-se em ajudar as pessoas a encontrar a ajuda de alguém que está disponível e empolgado por partilhar conhecimento.\n\n" +
                      "O nosso objetivo é começar pelo ambiente escolar agilizando a comunicação entre os alunos.\n",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'Minimo',
                      fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: Image.asset(
                  "assets/images/logo.png",
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(25, 25, 25, 15),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    child: Text("Got it!"),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff000000)),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xff7ceccc)),
                    ),
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
