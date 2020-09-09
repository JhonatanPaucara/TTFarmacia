import 'package:flutter/material.dart';
import 'package:ttfarmacia/utils/background.dart';
import 'package:ttfarmacia/models/basic.dart';

class ProductGroup extends StatefulWidget {
  ProductGroup({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _ProductGroupState createState() => _ProductGroupState();
}

class _ProductGroupState extends State<ProductGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: [
            background(context),
            Column(
              children: [
                SizedBox(height: 70),
                Center(
                  child: Text(
                    'SUPER ALIMENTOS ANDINOS',
                    style: TextStyle(
                        color: Colors.red[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  color: Colors.red[900],
                  thickness: 3,
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(height: 10),
                Container(
                    height: MediaQuery.of(context).size.height - 260,
                    width: MediaQuery.of(context).size.width,
                    child:
                        SingleChildScrollView(child: _productsGroup(context)))
              ],
            )
          ],
        ));
  }
}

Widget _productsGroup(context) {
  List<ProductItem> productos = [
    ProductItem(
        name: 'EcoAndino Quinua Gelatinizada', content: '250g', price: 16.5),
    ProductItem(name: 'Kroken mix de oro', content: '500g', price: 15.5),
    ProductItem(
        name: 'EcoAndino Algarrobo en polvo', content: '250g', price: 14.5),
    ProductItem(
        name: 'Américo andino Quinua tricolor', content: '340g', price: 13.5),
    ProductItem(name: 'Nutrimix Vigor', content: '200g', price: 12.5),
    ProductItem(
        name: 'EcoAndino Quinua Gelatinizada', content: '250g', price: 11.5),
    ProductItem(
        name: 'EcoAndino Quinua Gelatinizada', content: '250g', price: 10.5)
  ];
  return Column(
      children: List.generate(productos.length, (index) {
    return _productCard(context, productos[index]);
  }));
}

Widget _productCard(context, ProductItem producto) {
  final mWidth = MediaQuery.of(context).size.width;
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
    height: mWidth / 4,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.all(5),
          width: mWidth / 4.5,
          height: mWidth / 4.5,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.grey, offset: Offset(0, 4), blurRadius: 5)
            ],
            gradient: LinearGradient(
                colors: [Colors.grey[100], Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(mWidth / 9),
          ),
          child: Image.asset('fruta.png'),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 2.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                producto.name,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.red[900], fontSize: 18),
              ),
              Text(
                producto.content,
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.red[900], fontSize: 20),
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              width: 100,
              alignment: Alignment.center,
              child: Text(
                'S/. ${producto.price}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red[900], fontSize: 20),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(16)),
              child: IconButton(
                  icon: Icon(Icons.add),
                  iconSize: 16,
                  color: Colors.red[900],
                  onPressed: () {
                    Navigator.pushNamed(context, 'product',
                        arguments: producto);
                  }),
            )
          ],
        )
      ],
    ),
  );
}
