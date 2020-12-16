import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutoryall/app_auth_screens/login_screen.dart';
import 'package:tutoryall/app_auth_screens/register_screen.dart';

import 'home_page.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Widget _loginButton() {
    return RaisedButton(
      onPressed: () => {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LoginScreen(title: "Login Page")))
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      padding: EdgeInsets.symmetric(horizontal: 1),
      child: InkWell(
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
                fontSize: 25,
                fontFamily: 'Minimo',
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return RaisedButton(
      onPressed: () => {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterScreen(),
          ),
        )
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      padding: EdgeInsets.symmetric(horizontal: 1),
      color: Color(0xff7ceccc).withOpacity(0.9),
      child: InkWell(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xff7ceccc).withOpacity(0.9),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen(
      (User user) {
        if (user != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      },
    );
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
