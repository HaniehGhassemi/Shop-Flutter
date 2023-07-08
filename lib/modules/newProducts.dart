import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class newProducts extends StatefulWidget {
  const newProducts({Key? key}) : super(key: key);

  @override
  State<newProducts> createState() => _newProductsState();
}

class _newProductsState extends State<newProducts> {
  List<dynamic>? _categories = [];
  final formKey = GlobalKey<FormState>();
  late String dropdownValue = _categories?.first;
  String title = "";
  String description = "";
  String price = "";
  String image = "";
  String category = "";
  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return _categories!.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Product Title',
                        hintText: 'Enter Product Title',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Product Title Required';
                        }
                        title = value;
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Product Price',
                        hintText: 'Enter Product Price',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Product Price Required';
                        }
                        price = value;
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Product Category",
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 12)),
                        DropdownButtonFormField(
                            value: dropdownValue,
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            items: _categories!.map<DropdownMenuItem<dynamic>>(
                                (dynamic value) {
                              return DropdownMenuItem<dynamic>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: ((value) => {
                                  setState(() {
                                    dropdownValue = value!;
                                    category = value;
                                  })
                                })),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Product Description',
                        hintText: 'Enter Product Description',
                      ),
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Product Price Description';
                        }
                        description = value;
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 7.5,
                      ),
                      color: Colors.blue,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          var res = await createProduct();
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
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Future<void> getCategories() async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/categories'))
        .timeout(const Duration(minutes: 1), onTimeout: () {
      return http.Response('Http error', 400);
    });

    if (response.statusCode == 200) {
      //  final responseBody = utf8.decode(response.bodyBytes);
      final parsed = json.decode(response.body);
      print(parsed);

      setState(() {
        _categories = parsed;
      });
    }
  }

  Future<bool> createProduct() async {
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/products'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        title: title,
        price: double.parse(price),
        description: description,
        image: image,
        category: category
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
