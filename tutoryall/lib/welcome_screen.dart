/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Pedro Miguel Duque Rodrigues
 *   
*/

import 'package:flutter/material.dart';
import 'package:tutoryall/login_screen.dart';
import 'package:tutoryall/register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  final String title;

  WelcomeScreen({Key key, this.title}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Widget _loginButton() {
    return InkWell(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginScreen(title: "Login Page")))
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            border: Border.all(color: Colors.white, width: 2),
            color: Colors.white),
        child: Text(
          "Login",
          style: TextStyle(
              fontSize: 25, fontFamily: 'Minimo', fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return InkWell(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RegisterScreen(title: "Hello")))
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          'Register',
          style: TextStyle(
              fontSize: 25,
              color: Colors.black,
              fontFamily: 'Minimo',
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff82E3C4), Color(0xff7ceccc)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Image.asset(
                "assets/images/logo_alpha.png",
                height: MediaQuery.of(context).size.height * 0.6,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              _loginButton(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              _registerButton(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
