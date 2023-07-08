import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../models/product.dart';
import 'home_layout.dart';
import 'product_details.dart';

class SearchProductsPage extends StatefulWidget {
  String? categoryName;
  String? searchKey;
  RangeValues? priceRange;
  SearchProductsPage(
      {Key? key, this.searchKey, this.priceRange, this.categoryName})
      : super(key: key);

  @override
  State<SearchProductsPage> createState() => _SearchProductsPageState();
}

class _SearchProductsPageState extends State<SearchProductsPage> {
  List<Product>? _Products = [];
  List<dynamic>? _FilteredProducts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: AppBar(
            title: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                // Perform search functionality here
              },
            ),
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
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 5.0),
          color: Colors.white,
          child: ListView.builder(
            itemCount: _Products!.length,
            itemBuilder: (BuildContext context, int index) {
              Product product = _Products![index];
              double screenHeight = MediaQuery.of(context).size.height;
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductPage(productId: product.id),
                      ),
                    );
                  },
                  child: Material(
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
                                              color: Color.fromARGB(
                                                  255, 255, 94, 0),
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
                  ));
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ),
            );
          },
          child: const Icon(Icons.home, color: Color(0xFFF44336)),
        ));
  }

  Future<void> getProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      List<dynamic> parsed = json.decode(response.body);
      List<Product> products = [];
      products = Product.fromArrayJson(parsed);
      products = products
          .where((element) =>
              double.parse(element.price) >= widget.priceRange!.start &&
              double.parse(element.price) <= widget.priceRange!.end)
          .toList();
      if (widget.categoryName != "All" && widget.categoryName != null) {
        products = products
            .where((element) => element.category == widget.categoryName)
            .toList();
      }
      if (widget.searchKey != null && widget.searchKey != "") {
        products = products
            .where((element) => element.title
                .toLowerCase()
                .contains(widget.searchKey?.toLowerCase() as Pattern))
            .toList();
      }
      setState(() {
        _Products = products;
      });
    }
  }
}
