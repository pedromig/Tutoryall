import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tutoryall/core_screens/home_page.dart';
import 'package:tutoryall/core_screens/welcome_screen.dart';
import 'package:tutoryall/utils/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tutory\'all',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Database.auth.currentUser != null ? HomePage() : WelcomeScreen(),
    );
  }
}
