import 'package:demo_app_ananthan/constants/constants.dart';
import 'package:demo_app_ananthan/providers/cart_provider.dart';
import 'package:demo_app_ananthan/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  final String id;
  final String title;
  final String imageURL;
  final String desc;
  final double price;
  ProductItem(
      {@required this.id,
      @required this.title,
      @required this.imageURL,
      @required this.price,
      this.desc});
  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(right: 4, left: 8, top: 4, bottom: 4),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      widget.title,
                      style: kHeaderStyles,
                      softWrap: true,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text('₹${widget.price}'),
                    Consumer<CartProvider>(
                      builder: (_, cart, _2) =>
                          cart.items.containsKey(widget.id)
                              ? Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Row(mainAxisAlignment: MainAxisAlignment.center,
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
                                                .addItemToCart(widget.id,
                                                    widget.title, widget.price);
                                          }),
                                    ],
                                  ),
                              )
                              : Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Add to cart'),
                                      IconButton(
                                          icon: Icon(Icons.add_shopping_cart),
                                          onPressed: () {
                                            Provider.of<CartProvider>(context,
                                                    listen: false)
                                                .addItemToCart(widget.id,
                                                    widget.title, widget.price);
                                          }),
                                    ],
                                  ),
                              ),
                    )
                  ],
                ),
                Container(
                  height: 100,
                  width: 150,
                  child: widget.imageURL.isEmpty
                      ? Image.asset('assets/images/placeholder.png')
                      : Image.network(
                          widget.imageURL,
                          fit: BoxFit.cover,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(
                    id: widget.id,
                    title: widget.title,
                    desc: widget.desc,
                    imageURL: widget.imageURL,
                    price: widget.price,
                  )),
        );
      },
    );
  }
}
