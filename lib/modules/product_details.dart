import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'home_layout.dart';

class ProductPage extends StatefulWidget {
  int? productId;
  ProductPage({Key? key, this.productId}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Map<String, dynamic>? productData;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    var response = await http.get(
        Uri.parse('https://fakestoreapi.com/products/${widget.productId}'));
    if (response.statusCode == 200) {
      setState(() {
        productData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load product data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: productData == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      height: 500,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          productData?['image'],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        productData?['title'],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Category: ${productData?['category']}',
                            style: TextStyle(
                              fontSize: 16,
                              color: const Color.fromARGB(255, 98, 98, 98),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            productData?['description'],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.grey[100],
            items: [
              BottomNavigationBarItem(
                icon: Text(
                  '\$${productData?['price']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF44336),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: Icon(Icons.shopping_cart_outlined),
                  selectedIcon: Icon(
                    Icons.supervisor_account,
                    color: Color(0xFFF44336),
                  ),
                  onPressed: () async {
                    var res = await addToCart();
                    if (res == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Successful',
                          ),
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.all(25),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Error',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.all(25),
                        ),
                      );
                    }
                  },
                ),
                label: '',
              )
            ],
          ),
        ));
  }

  Future<bool> addToCart() async {
    var response = await http.post(
      Uri.parse('https://fakestoreapi.com/carts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          'userId': 5,
          'date': '2020-02-03',
          'products': [
            {'productId': 5, 'quantity': 1},
            {'productId': 1, 'quantity': 5},
          ],
        },
      ),
    );
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      return true;
    } else {
      return false;
    }
  }
}
