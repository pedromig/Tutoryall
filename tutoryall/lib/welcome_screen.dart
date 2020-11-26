import 'package:flutter/material.dart';
import 'package:tutoryall/login_screen.dart';
import 'package:tutoryall/main.dart';
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
        Navigator.push(context, 
            MaterialPageRoute(builder: (context) => LoginScreen(title: "Login Page")))
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
          style: TextStyle(fontSize: 25, fontFamily: 'Minimo', fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return InkWell(
      onTap: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RegisterScreen(title: "Hello")))
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
              fontSize: 25, color: Colors.black, fontFamily: 'Minimo', fontWeight: FontWeight.w500),
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
              Image.asset("assets/images/logo.png", width: 300, height: 400),
              SizedBox(
                height: 60,
              ),
              _loginButton(),
              SizedBox(
                height: 20,
              ),
              _registerButton(),
            ],
          ),
        ),
      ),
    );
  }
}
