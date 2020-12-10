/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Pedro Miguel Duque Rodrigues
 *   
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutoryall/main.dart';
import 'package:tutoryall/welcome_screen.dart';

import 'home_page.dart';

class RegisterScreen extends StatefulWidget {
  final String title;

  RegisterScreen({Key key, this.title}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _repeatPassword = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _emailError = "";
  String _passwordError = "";
  String _repeatPasswordError;

  void dispose() {
    _password.dispose();
    _email.dispose();
    _repeatPassword.dispose();
    super.dispose();
  }

  void _register() async {
    try {
      if (_repeatPassword.text == _password.text) {
        _showLoaderDialog(context);
        await _auth
            .createUserWithEmailAndPassword(
                email: _email.text, password: _password.text)
            .then(
              (value) => {
                setState(() {
                  _passwordError = "";
                  _emailError = "";
                  _repeatPasswordError = null;
                }),
                Navigator.pop(context),
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                ),
              },
            );
      }
    } on FirebaseAuthException catch (e) {
      _emailError = "";
      _passwordError = "";
      _repeatPasswordError = null;
      setState(() {
        if (e.code == "email-already-in-use") {
          _emailError = "Email already in use";
        } else if (e.code == "invalid-email") {
          _emailError = "Invalid email";
        } else if (e.code == "weak-password") {
          _passwordError = "Password must have 6-12 characters";
        } else {
          if (_email.text.isEmpty) _emailError = "required";
          if (_password.text.isEmpty) _passwordError = "required";
          if (_repeatPassword.text.isEmpty) _repeatPasswordError = "required";
        }
      });
      Navigator.pop(context);
    }
  }

  _showLoaderDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: Color(0xfff2f3f5),
          content: new Row(
            children: [
              CircularProgressIndicator(value: null),
              Container(
                  margin: EdgeInsets.only(left: 7),
                  child: Text("Registering...")),
            ],
          ),
        );
      },
    );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (contex) => WelcomeScreen()),
      ),
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

  Widget _registerTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Register",
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
          TextFormField(
            controller: _email,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              errorStyle: TextStyle(
                  fontFamily: 'Minimo',
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
              errorText: _emailError.isEmpty ? null : _emailError,
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
      padding: EdgeInsets.symmetric(vertical: 20),
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
          TextFormField(
            controller: _password,
            obscureText: true,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              errorStyle: TextStyle(
                  fontFamily: 'Minimo',
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
              errorText: _passwordError.isEmpty ? null : _passwordError,
              fillColor: Color(0xffffffff),
              filled: true,
              prefixIcon: Icon(Icons.lock, color: Colors.black, size: 30),
            ),
          )
        ],
      ),
    );
  }

  Widget _repeatPasswordInput(String title) {
    return Container(
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
          TextFormField(
            controller: _repeatPassword,
            obscureText: true,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              errorStyle: TextStyle(
                  fontFamily: 'Minimo',
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
              errorText: _password.text != _repeatPassword.text &&
                      _repeatPassword.text.isNotEmpty
                  ? "Password mismatch"
                  : _repeatPasswordError,
              fillColor: Color(0xffffffff),
              filled: true,
              prefixIcon: Icon(Icons.lock, color: Colors.black, size: 30),
            ),
          )
        ],
      ),
    );
  }

  Widget _registerButton() {
    return InkWell(
      onTap: _register,
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
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
        );
      },
      child: Scaffold(
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
                          _registerTitle(),
                          Column(
                            children: <Widget>[
                              _emailInput("Email"),
                              _passwordInput("Password"),
                              _repeatPasswordInput("Confirm Password"),
                            ],
                          ),
                          SizedBox(height: 35),
                          _registerButton(),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              child: Text(""),
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
        ),
      ),
    );
  }
}
