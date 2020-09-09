import 'package:flutter/material.dart';
import 'package:ttfarmacia/views/login.dart';
import 'package:ttfarmacia/views/home.dart';
import 'package:ttfarmacia/views/pharmacy.dart';
import 'package:ttfarmacia/views/productGroup.dart';
import 'package:ttfarmacia/views/product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TTFarmacia',
      initialRoute: 'login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        'login': (BuildContext context) => Login(title: 'TTFarmacia_Login'),
        'home': (BuildContext context) => Home(title: 'TTFarmacia_Home'),
        'pharmacy': (BuildContext context) =>
            Pharmacy(title: 'TTFarmacia_Pharmacy'),
        'productGroup': (BuildContext context) =>
            ProductGroup(title: 'TTFarmacia_ProductGroup'),
        'product': (BuildContext context) =>
            Product(title: 'TTFarmacia_Product'),
      },
      home: Login(title: 'TTFarmacia'),
    );
  }
}
