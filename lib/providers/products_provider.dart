import 'dart:convert';
import '../models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  Product getProductByName(String pName) {
    return _items.firstWhere((element) => element.title.contains(pName));
  }

  Future<void> fetchAndSetProductsByCatId() async {
    _items.clear();
    var url =
        'https://seedsbag.com/wp-json/wc/v3/products?consumer_key=ck_17f41c87bd388326ca04feb42e9a74154c6154c0&consumer_secret=cs_8d35e70c5c68930a0697018c181077bec3a1e054';
    try {
      final response = await http.get(url);
      final prodData = json.decode(response.body) as List<dynamic>;
      //print(prodData);
      List<Product> newList = [];
      prodData.forEach((prod) {
        var newProduct = Product(
            id: prod['id'].toString(),
            title: prod['name'] ?? "",
            desc: prod['description'] ?? "Description not found",
            imageURL:
                prod['images'].length == 0 ? "" : prod['images'][0]['src'],
            price: prod['sale_price'] == ""
                ? 0
                : double.parse(prod['sale_price'].toString()));
        //print(newProduct.id);
        newList.add(newProduct);
      });

      //print(_items.length);
      //print(_items[0]);
      _items = newList;
      //print(_items.length);
    } catch (error) {
      print('Error in fetchProducts method - ${error.toString()}');
      throw error;
    }

    notifyListeners();
  }
}
