import 'package:flutter/material.dart';
import 'package:treehacksApp/screens/welcome_screen.dart';
import 'package:treehacksApp/screens/login_screen.dart';
import 'package:treehacksApp/screens/registration_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),

      initialRoute:WelcomeScreen.id,
      routes: {
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        LoginScreen.id: (context)=>LoginScreen(),
        RegistrationScreen.id: (context)=>RegistrationScreen(),

      },
    );
  }
}
