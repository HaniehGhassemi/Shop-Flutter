import 'package:flutter/material.dart';
import 'modules/home_layout.dart';
import 'modules/search_product.dart';

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
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}