import 'package:flutter/material.dart';
import 'package:flutter_application_4/modules/about_us.dart';
import 'package:flutter_application_4/modules/newProducts.dart';
import 'package:flutter_application_4/modules/userList.dart';
import 'homePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  int index = 0;
  final screens = [
    HomePage(),
    UserList(),
    NewProduct(),
    AboutUs(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: Colors.transparent,
              labelTextStyle: MaterialStateProperty.all(TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFF44336)))),
          child: NavigationBar(
              height: 70,
              backgroundColor: Colors.grey[100],
              labelBehavior:
                  NavigationDestinationLabelBehavior.onlyShowSelected,
              selectedIndex: index,
              animationDuration: Duration(seconds: 1),
              onDestinationSelected: (index) => setState(() {
                    this.index = index;
                  }),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(
                    Icons.home,
                    color: Color(0xFFF44336),
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                    icon: Icon(Icons.supervisor_account_outlined),
                    selectedIcon: Icon(
                      Icons.supervisor_account,
                      color: Color(0xFFF44336),
                    ),
                    label: 'Customers'),
                NavigationDestination(
                    icon: Icon(Icons.add_outlined),
                    selectedIcon: Icon(
                      Icons.add,
                      color: Color(0xFFF44336),
                    ),
                    label: 'New'),
                NavigationDestination(
                  icon: Icon(Icons.info_outlined),
                  selectedIcon: Icon(
                    Icons.info,
                    color: Color(0xFFF44336),
                  ),
                  label: 'About us',
                ),
              ])),
    );
  }
}
