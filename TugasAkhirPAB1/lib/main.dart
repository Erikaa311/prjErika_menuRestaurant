import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(FodieApp());
}

class FodieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FodieApp',
      home: LoginScreen(), 
    );
  }
}
