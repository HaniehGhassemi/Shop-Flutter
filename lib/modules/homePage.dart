import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'product_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = [];
  List<Product> newProducts = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchNewProducts();
  }

  Future<void> fetchCategories() async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'));
    if (response.statusCode == 200) {
      setState(() {
        categories = List<String>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> fetchNewProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      setState(() {
        Iterable list = json.decode(response.body);
        newProducts = list.map((model) => Product.fromJson(model)).toList();
      });
    } else {
      throw Exception('Failed to load new products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductsPage(categoryName: categories[index]),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 0 : 16,
                      ),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              'New Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: newProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(newProducts[index].image),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                newProducts[index].title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${newProducts[index].price}\$',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class CategoryPage extends StatefulWidget {
//   final String categoryName;

//   CategoryPage({required this.categoryName});

//   @override
//   _CategoryPageState createState() => _CategoryPageState();
// }

// class _CategoryPageState extends State<CategoryPage> {
//   List<Product> categoryProducts = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchCategoryProducts();
//   }

//   Future<void> fetchCategoryProducts() async {
//     final response = await http.get(Uri.parse(
//         'https://fakestoreapi.com/products/category/${widget.categoryName}'));
//     if (response.statusCode == 200) {
//       setState(() {
//         Iterable list = json.decode(response.body);
//         categoryProducts =
//             list.map((model) => Product.fromJson(model)).toList();
//       });
//     } else {
//       throw Exception('Failed to load category products');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.builder(
//           itemCount: categoryProducts.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 0.75,
//             crossAxisSpacing: 16,
//             mainAxisSpacing: 16,
//           ),
//           itemBuilder: (context, index) {
//             return Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: NetworkImage(categoryProducts[index].image),
//                           fit: BoxFit.cover,
//                         ),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           categoryProducts[index].title,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           '${categoryProducts[index].price}\$',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class Product {
  final int id;
  final String title;
  final double price;
  final String image;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.image});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}

class ProductPage extends StatefulWidget {
  final int productId;

  ProductPage({required this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Product? product;

  @override
  void initState() {
    super.initState();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products/${widget.productId}'));
    if (response.statusCode == 200) {
      setState(() {
        product = Product.fromJson(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load product');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(product!.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              product!.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${product!.price}\$',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
