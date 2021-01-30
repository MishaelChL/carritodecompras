import 'package:carritodecomprasdefrutas/pages/grocery_home_page.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grocery Page',
        initialRoute: 'grocery_home_page',
        routes: {
          'grocery_home_page' : ( BuildContext context )  => GroceryHomePage(),
        },
      );
  }
}