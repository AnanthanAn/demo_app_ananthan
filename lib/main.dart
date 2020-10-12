import 'package:demo_app_ananthan/providers/cart_provider.dart';
import 'package:demo_app_ananthan/providers/products_provider.dart';
import 'package:demo_app_ananthan/screens/cart_screen.dart';
import 'package:demo_app_ananthan/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (ctx) => ProductsProvider(),),
      ChangeNotifierProvider(create: (ctx) => CartProvider(),),
    ],
      child: MaterialApp(

        title: 'Demo App',
        theme: ThemeData(
            primaryColor: Color(0xff1fab89),accentColor: Color(0xff1fab89),

            textTheme:
            GoogleFonts.kronaOneTextTheme(Theme.of(context).textTheme),
            primaryTextTheme:
            GoogleFonts.kronaOneTextTheme(Theme.of(context).textTheme)),
        home: HomeScreen(),routes: {
          CartScreen.routeName : (context) => CartScreen(),
      },
      ),
    );
  }
}
