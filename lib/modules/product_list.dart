import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductsPage extends StatefulWidget {
  String? categoryName;
  ProductsPage({Key? key, this.categoryName}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<dynamic>? _categoryProducts = [];

  @override
  void initState() {
    getCategoryProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _categoryProducts!.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            body: Container(
            padding: const EdgeInsets.only(top: 5.0),
            color: Colors.white,
            child: ListView.builder(
              itemCount: _categoryProducts!.length,
              itemBuilder: (BuildContext context, int index) {
                Product product = Product.fromJson(_categoryProducts![index]);
                double screenHeight = MediaQuery.of(context).size.height;
                return Material(
                  borderRadius: BorderRadius.circular(20.0),
                  // clipBehavior: Clip.hardEdge,
                  child: Container(
                    height: screenHeight / 4.5,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 245, 246, 247),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          product.image,
                          height: screenHeight / 4.5,
                          width: screenHeight / 4.5,
                          fit: BoxFit.contain,
                          alignment: Alignment.center,
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20.0, right: 30.0),
                                          child: Text(
                                            product.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 19.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 10.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 12,
                                            ),
                                            const SizedBox(
                                              width: 5.0,
                                            ),
                                            Text(
                                              '${product.rating['rate']}',
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 94, 0),
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
                                        Text(
                                          '${product.price} EGP',
                                          style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 255, 94, 0),
                                            fontSize: 18.0,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ));
  }

  Future<void> getCategoryProducts() async {
    final response = await http.get(Uri.parse(
        'https://fakestoreapi.com/products/category/${widget.categoryName}'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      print(parsed);

      setState(() {
        _categoryProducts = parsed;
      });
    }
  }
}
