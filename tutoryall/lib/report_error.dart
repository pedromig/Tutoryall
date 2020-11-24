import 'package:flutter/material.dart';

class ReportError extends StatefulWidget {
  @override
  _ReportErrorState createState() => _ReportErrorState();
}

class _ReportErrorState extends State<ReportError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reportar Erros"),
        centerTitle: true,
      ),
    );
  }
}