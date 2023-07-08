import 'package:flutter/material.dart';
import 'package:flutter_application_4/modules/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      builder: (context, child) {
        return Scaffold(
          body: child,
        );
      },
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
