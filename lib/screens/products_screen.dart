import 'package:demo_app_ananthan/models/product.dart';
import 'package:demo_app_ananthan/providers/products_provider.dart';
import 'package:demo_app_ananthan/widgets/products_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  var _isLoading = false;
  @override
  void initState() {
    _refreshPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> _products = Provider.of<ProductsProvider>(context).items;
    return Scaffold(
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : RefreshIndicator(
        onRefresh: () => _refreshPage(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemBuilder: (context, idx) => ProductItem(
              id: _products[idx].id,
              title: _products[idx].title,
              imageURL: _products[idx].imageURL,
              price: _products[idx].price,
              desc: _products[idx].desc,
            ),
            itemCount: _products.length,
          ),
        ),
      ),
    );
  }

  Future<void> _refreshPage() async {
    setState(() {
      _isLoading = true;
    });
    var result = await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProductsByCatId();
    setState(() {
      _isLoading = false;
    });
    return result;
  }
}
