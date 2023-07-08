import 'package:flutter/material.dart';
import 'package:flutter_application_4/modules/home_layout.dart';
import 'package:flutter_application_4/modules/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      builder: (context, child) {
        return Scaffold(
          appBar: MyAppBar(),
          body: child,
        );
      },
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(56.0),
      child: AppBar(
        title: SizedBox.shrink(),
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Center(
            child: Transform.scale(
              scale: 2.5,
              child: Image.asset('img/buyme.png'),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              icon: Icon(Icons.search, color: Color(0xFF080808)),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
