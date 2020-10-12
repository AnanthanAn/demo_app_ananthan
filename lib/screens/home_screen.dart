import '../constants/constants.dart';
import '../providers/cart_provider.dart';
import '../screens/cart_screen.dart';
import '../screens/products_screen.dart';
import '../screens/search_screen.dart';
import '../widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedWidgetIndex = 0;
  List<Widget> _screens = [
    ProductScreen(),
    SearchScreen(),
    CartScreen(
      appBarFlag: true,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Store',style: kAppBarTitleStyles,),
        actions: <Widget>[
          Consumer<CartProvider>(
            builder: (ctx, cart, _) => Badge(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                },
              ),
              value: cart.items.length.toString(),
              color: Colors.lightGreenAccent,
            ),
          ),
        ],
      ),
      body: _screens[_selectedWidgetIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedWidgetIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text('Search')),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text('Cart')),
        ],
        onTap: (index) {
          setState(() {
            _selectedWidgetIndex = index;
          });
        },
      ),
    );
  }
}
