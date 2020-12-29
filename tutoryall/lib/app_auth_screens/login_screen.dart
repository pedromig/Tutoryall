/**
 * Licenciatura em Engenharia Informática | Faculdade de Ciências e Tecnologia da Universidade de Coimbra
 * Projeto de PGI - Tutory'all 2020/2021
 * 
 * File Author: Pedro Miguel Duque Rodrigues
 *   
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutoryall/core_screens/welcome_screen.dart';
import 'package:tutoryall/utils/database.dart';
import '../core_screens/home_page.dart';

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

  String _passwordError = "";
  String _emailError = "";

  void dispose() {
    _password.dispose();
    _email.dispose();
    super.dispose();
  }

  void _login() async {
    try {
      _showLoaderDialog(context);
      await Database.signIn(_email.text.trim(), _password.text).then(
        (value) => {
          setState(() {
            _passwordError = "";
            _emailError = "";
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
    } on FirebaseAuthException catch (e) {
      _passwordError = "";
      _emailError = "";
      setState(() {
        if (e.code == "invalid-email") {
          _emailError = "Invalid email";
        } else if (e.code == "user-not-found") {
          _emailError = "No user with such email";
        } else if (e.code == "wrong-password") {
          _passwordError = "Incorrect password";
        } else {
          if (_email.text.isEmpty) _emailError = "required";
          if (_password.text.isEmpty) _passwordError = "required";
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
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          backgroundColor: Color(0xfff2f3f5),
          content: new Row(
            children: [
              CircularProgressIndicator(value: null),
              Container(
                  margin: EdgeInsets.only(left: 7),
                  child: Text("Loging In...")),
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
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      ),
      child: InkWell(
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
          TextFormField(
            controller: _password,
            obscureText: !_showPassword,
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
    return RaisedButton(
      onPressed: _login,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            border: Border.all(color: Colors.white, width: 2),
            color: Colors.white,
          ),
          child: Text(
            "Submit",
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'Minimo',
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  void _forgetPassword() {
    TextEditingController _passwordRecovery = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: Color(0xfff2f3f5),
          title: Text("Password recovery"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: "Email",
                  ),
                  controller: _passwordRecovery,
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Text('Submit', style: TextStyle(color: Colors.black)),
                  onPressed: () async {
                    Database.recoverPassword(_passwordRecovery.text.trim());
                    Navigator.pop(context);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
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
                                _forgetPassword(),
                              },
                              child: Text('Forgot Password ?',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
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
