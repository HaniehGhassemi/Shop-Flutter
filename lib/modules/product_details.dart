import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Map<String, dynamic> productData;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    var response =
        await http.get(Uri.parse('https://fakestoreapi.com/products/1'));
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
      body: productData == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.all(16),
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        productData['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      productData['title'],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          '\$${productData['price']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[800],
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '\$${productData['price']}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Category: ${productData['category']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          productData['description'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () {
                        addToCart();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFF44336),
                      ),
                      child: Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future addToCart() async {
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
      print(responseData);
    } else {
      throw Exception('Failed to add item to cart');
    }
  }
}
