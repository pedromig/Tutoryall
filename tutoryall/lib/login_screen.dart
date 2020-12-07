/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Pedro Miguel Duque Rodrigues
 *   
*/

import 'package:flutter/material.dart';
import 'package:tutoryall/main.dart';

import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  TextEditingController _password = TextEditingController();
  TextEditingController _email = TextEditingController();

  void dispose() {
    _password.dispose();
    _email.dispose();
    super.dispose();
  }

  Widget _backButton() {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 30, bottom: 33),
              child: Icon(Icons.keyboard_arrow_left,
                  color: Colors.black, size: 30),
            ),
            Text('Back',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Minimo",
                    fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _loginTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: TextStyle(
                fontSize: 50,
                fontFamily: "Minimo",
                fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget _emailInput(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _email,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              fillColor: Color(0xffffffff),
              filled: true,
              prefixIcon: Icon(Icons.email, color: Colors.black, size: 30),
            ),
          )
        ],
      ),
    );
  }

  Widget _passwordInput(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _password,
            obscureText: !_showPassword,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              fillColor: Color(0xffffffff),
              filled: true,
              prefixIcon: Icon(Icons.lock, color: Colors.black, size: 30),
              suffixIcon: IconButton(
                icon: Icon(Icons.remove_red_eye_rounded,
                    color: this._showPassword ? Colors.blue : Colors.grey),
                onPressed: () =>
                    {setState(() => this._showPassword = !this._showPassword)},
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _loginButton() {
    return InkWell(
      onTap: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage(user: null)))
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            border: Border.all(color: Colors.white, width: 2),
            color: Colors.white),
        child: Text(
          "Submit",
          style: TextStyle(
              fontSize: 25, fontFamily: 'Minimo', fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff82E3C4), Color(0xff7ceccc)])),
            child: ListView(
              children: <Widget>[
                _backButton(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/images/lightbulb.png",
                          height: MediaQuery.of(context).size.height * 0.2),
                      _loginTitle(),
                      SizedBox(height: 30),
                      Column(
                        children: <Widget>[
                          _emailInput("Email"),
                          _passwordInput("Password"),
                        ],
                      ),
                      SizedBox(height: 20),
                      _loginButton(),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(user: null)))
                          },
                          child: Text('Forgot Password ?',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
