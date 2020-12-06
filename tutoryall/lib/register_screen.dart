import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutoryall/main.dart';

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

  void dispose() {
    _password.dispose();
    _email.dispose();
    super.dispose();
  }

  void _register() async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: _email.text, password: _password.text)
          .then(
            (value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(title: value.user.email),
              ),
            ),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        print("Already exists xD");
      } else if (e.code == "invalid-email") {
        print("Invalid email xD");
      } else if (e.code == "weak-password") {
        print("Weak password xD");
      } else {
        print("Error: Please setup configurations in your flutter page");
      }
    }
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
              fillColor: Color(0xffffffff),
              filled: true,
              prefixIcon: Icon(Icons.email, color: Colors.black, size: 30),
            ),
          )
        ],
      ),
    );
  }

  _controller(bool isRepeat) {
    return isRepeat ? _repeatPassword : _password;
  }

  Widget _passwordInput(String title, bool isRepeat) {
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
            controller: _controller(isRepeat),
            obscureText: true,
            decoration: InputDecoration(
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
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff82E3C4), Color(0xff7ceccc)])),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * 0.17),
                    Image.asset("assets/images/lightbulb.png",
                        width: 100, height: 150),
                    _registerTitle(),
                    SizedBox(height: 30),
                    Column(
                      children: <Widget>[
                        _emailInput("Email"),
                        _passwordInput("Password", false),
                        _passwordInput("Repeat Password", true),
                      ],
                    ),
                    SizedBox(height: 20),
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
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
