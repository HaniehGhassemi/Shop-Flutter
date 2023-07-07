import 'dart:convert';
import 'package:flutter_application_4/models/user.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<dynamic> _users = [];
  bool _customTileExpanded = false;

  @override
  void initState() {
    getCategoryProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _users.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              title: const Text("users"),
            ),
            body: Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (BuildContext context, int index) {
                  User user = User.fromJson(_users[index]);
                  return Material(
                    borderRadius: BorderRadius.circular(20.0),
                    child: ExpansionTile(
                      backgroundColor: const Color.fromARGB(255, 245, 246, 247),
                      title: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                "img/circleAvatar.jpg",
                              ),
                              radius: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${user.name.firstname} ${user.name.lastname}'),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(user.email,
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                            ],
                          )
                        ],
                      ),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'username: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        user.username,
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 88, 109, 119),
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'email: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        user.email,
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 88, 109, 119),
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'city: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        user.address.city,
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 88, 109, 119),
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'street: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        user.address.street,
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 88, 109, 119),
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'zipcode: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        user.address.zipcode,
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 88, 109, 119),
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'pohone: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      Text(
                                        user.phone,
                                        style: const TextStyle(
                                          color: Color.fromARGB(255, 88, 109, 119),
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                      onExpansionChanged: (bool expanded) {
                        setState(() {
                          _customTileExpanded = expanded;
                        });
                      },
                    ),
                    //
                    // Container(
                    //   height: screenHeight / 3.2,
                    //   margin: const EdgeInsets.all(10),
                    //   decoration: BoxDecoration(
                    //     color: const Color.fromARGB(255, 245, 246, 247),
                    //     borderRadius: BorderRadius.circular(15.0),
                    //   ),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Image.asset(
                    //         "img/person.png",
                    //         height: screenHeight / 4.5,
                    //         width: screenHeight / 4.5,
                    //         fit: BoxFit.cover,
                    //         alignment: Alignment.center,

                    //       ),
                    //       const SizedBox(
                    //         width: 20.0,
                    //       ),
                    //       Expanded(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Stack(
                    //               alignment: Alignment.topRight,
                    //               children: [
                    //                 Row(
                    //                   children: [
                    //                     Expanded(
                    //                       child: Padding(
                    //                         padding: const EdgeInsets.only(
                    //                             top: 20.0, right: 30.0),
                    //                         child: Text(
                    //                           '${user.name.firstname} ${user.name.lastname}',
                    //                           maxLines: 2,
                    //                           overflow: TextOverflow.ellipsis,
                    //                           style: const TextStyle(
                    //                             fontSize: 19.0,
                    //                             fontWeight: FontWeight.w700,
                    //                             color: Colors.black,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //             // const Spacer(),
                    //             Padding(
                    //               padding: const EdgeInsets.only(
                    //                   bottom: 10.0, top: 10.0),
                    //               child: Row(
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Column(
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                     children: [

                    //                     ],
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  );
                },
              ),
            ));
  }

  Future<void> getCategoryProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/users'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      print(parsed);

      setState(() {
        _users = parsed;
      });
    }
  }
}
