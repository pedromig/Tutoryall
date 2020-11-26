import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final String title;

  RegisterScreen({Key key, this.title}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal[200],
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hello",
            style: TextStyle(fontFamily: 'Minimo'),
          )
        ],
      ),
    );
  }
}
