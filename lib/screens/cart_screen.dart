import 'package:demo_app_ananthan/constants/constants.dart';
import 'package:demo_app_ananthan/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final bool appBarFlag;
  static String routeName = '/cart-screen';

  CartScreen({this.appBarFlag});
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: widget.appBarFlag == null
          ? AppBar(
              title: Text('My Cart',style: kAppBarTitleStyles,),
            )
          : null,
      key: key,
      body: Column(
        children: <Widget>[
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Total'),
                Chip(
                  label: Text('₹ ${cart.totalAmount.toString()}'),
                ),
              ],
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (ctx, idx) => Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          cart.removeProductFromCart(
                              cart.items.keys.toList()[idx]);
                        },
                        background: Container(
                          color: Colors.redAccent,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 24,
                          ),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 10),
                        ),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(cart.items.values.toList()[idx].title),
                                Consumer<CartProvider>(
                                  builder: (_, cart, _2) =>
                                      // cart.items.containsKey(cart.items.values.toList()[idx].id) ?
                                      Row(
                                    children: <Widget>[
                                      IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            setState(() {
                                              print(
                                                  'Prod id in cart -------------------- ${cart.items.values.toList()[idx].id}');
                                              Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .decreaseQuantityCart(cart
                                                      .items.values
                                                      .toList()[idx]
                                                      .id);
                                            });
                                          }),
                                      Text(
                                          '${cart.items.values.toList()[idx].quantity}'),
                                      IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            setState(() {
                                              print(
                                                  'Prod id cart-------------------- ${cart.items.values.toList()[idx].id}');
                                              Provider.of<CartProvider>(context,
                                                      listen: false)
                                                  .addItemToCart(
                                                      cart.items.values
                                                          .toList()[idx]
                                                          .id,
                                                      cart.items.values
                                                          .toList()[idx]
                                                          .title,
                                                      cart.items.values
                                                          .toList()[idx]
                                                          .price);
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                                Text('₹'+(cart.items.values.toList()[idx].quantity *
                                        cart.items.values
                                            .toList()[idx]
                                            .price)
                                    .toString()),
                              ],
                            ),
                          ),
                        )
                        // ListTile(
                        //   title: Text(cart.items.values.toList()[idx].title),
                        //   trailing: Text(cart.items.values
                        //       .toList()[idx]
                        //       .quantity
                        //       .toString()),
                        // ),
                        ),
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text('Do you want to place the order?'),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text('No')),
                  FlatButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        Navigator.pop(ctx);
                        // await Provider.of<OrderProvider>(context, listen: false)
                        //     .placeOrder(
                        //     cart.totalAmount, cart.items.values.toList());
                        // Provider.of<CartProvider>(context, listen: false)
                        //     .clearCart();
                        // Navigator.pop(context);
                      },
                      child: Text('Yes')),
                ],
              ),
            );
          },
          label: Text('Place Order')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
