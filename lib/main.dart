import 'package:flutter/material.dart';
import 'package:flutter_app/constants/material_white.dart';
import 'package:flutter_app/screens/auth_screen.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      // home: AuthScreen(),
      theme: ThemeData(primarySwatch: white),
    );
  }

}
