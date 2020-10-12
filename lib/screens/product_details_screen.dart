import 'package:demo_app_ananthan/constants/constants.dart';
import 'package:demo_app_ananthan/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';

  final String id;
  final String title;
  final String desc;
  final String imageURL;
  final double price;

  ProductDetailsScreen(
      {this.id, this.title, this.desc, this.imageURL, this.price});
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: kAppBarTitleStyles,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              //height: 300,
              //width: 150,
              child: widget.imageURL.isEmpty
                  ? Image.asset('assets/images/placeholder.png')
                  : Image.network(
                      widget.imageURL,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.title,
              softWrap: true,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '₹${widget.price}',
              softWrap: true,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Consumer<CartProvider>(
              builder: (_, cart, _2) => cart.items.containsKey(widget.id)
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .decreaseQuantityCart(widget.id);
                              }),
                          Text('${cart.items[widget.id].quantity}'),
                          IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .addItemToCart(
                                        widget.id, widget.title, widget.price);
                              }),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton.icon(
                            onPressed: () {
                              Provider.of<CartProvider>(context, listen: false)
                                  .addItemToCart(
                                      widget.id, widget.title, widget.price);
                            },
                            icon: Icon(Icons.add_shopping_cart),
                            label: Text('Add to Cart'),
                          ),
                        ],
                      ),
                    ),
            ),
            Text(
              widget.desc,
              softWrap: true,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
