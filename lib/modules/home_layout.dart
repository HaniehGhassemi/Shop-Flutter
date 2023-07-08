import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_4/modules/about_us.dart';
import 'package:flutter_application_4/modules/newProducts.dart';
import 'package:flutter_application_4/modules/users_list.dart';
import '../main.dart';
import 'homePage.dart';
import 'search_product.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  int index = 0;
  final screens = [
    HomePage(),
    UsersPage(),
    newProducts(),
    AboutUs(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
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

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({Key? key}) : super(key: key);
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
              icon: const Icon(Icons.search, color: Color(0xFF080808)),
              onPressed: () {
                ModalBottomSheet modal = ModalBottomSheet();
                modal._showBottomModal(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}

class ModalBottomSheet {
  Future<dynamic> getCategories() async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'))
        .timeout(const Duration(minutes: 1), onTimeout: () {
      return http.Response('Http error', 400);
    });

    if (response.statusCode == 200) {
      //  final responseBody = utf8.decode(response.bodyBytes);
      final parsed = json.decode(response.body);
      print(parsed);

      return parsed;
    } else {
      print('sdf df sdfs dgsaklswdnfsvndl');
    }
  }

  static List<dynamic>? list = [];
  static String dropdownValue = list!.first;
  var selectedrange = const RangeValues(0, 1000);
  String searchKey = "";
  Future<void> _showBottomModal(context) async {
    list = await getCategories();
    list?.add("All");
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (builder) {
          return StatefulBuilder(
            builder: (BuildContext context,
                StateSetter setState /*You can rename this!*/) {
              return Container(
                // height: 800,
                color: Colors.transparent,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius:
                            10.0, // has the effect of softening the shadow
                        spreadRadius:
                            0.0, // has the effect of extending the shadow
                      )
                    ],
                  ),
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(top: 5, left: 10),
                            child: const Text(
                              "search products",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87),
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 5, right: 5),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "close",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff999999),
                                  ),
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Color(0xfff8f8f8),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                 TextField(
                                  onChanged:(value) => {
                                              setState(() {
                                                searchKey = value;
                                              })
                                            } ,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Enter a product name...',
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text("filter by category",
                                        style:
                                            TextStyle(color: Colors.blueGrey)),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    DropdownButtonFormField(
                                        value: dropdownValue,
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.deepPurple),
                                        items: list!
                                            .map<DropdownMenuItem<dynamic>>(
                                                (dynamic value) {
                                          return DropdownMenuItem<dynamic>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: ((value) => {
                                              setState(() {
                                                dropdownValue = value!;
                                                print(value);
                                              })
                                            })),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text("filter by price",
                                        style:
                                            TextStyle(color: Colors.blueGrey)),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    RangeSlider(
                                        values: selectedrange,
                                        onChanged: (RangeValues newRange) {
                                          setState(
                                              () => selectedrange = newRange);
                                          print(selectedrange);
                                        },
                                        min: 0,
                                        max: 1000,
                                        labels: RangeLabels(
                                            '${selectedrange.start}',
                                            '${selectedrange.end}'),
                                        divisions: 20),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SearchProductsPage(
                                              searchKey: searchKey,
                                              priceRange: selectedrange,
                                              categoryName: dropdownValue,
                                              ),
                                        ),
                                      );
                                    },
                                    child: const Text('Search'))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
