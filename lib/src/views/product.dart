import 'package:flutter/material.dart';
import 'package:ttfarmacia/src/utils/background.dart';
import 'package:ttfarmacia/src/models/basic.dart';

class Product extends StatefulWidget {
  Product({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    ProductItem producto = ModalRoute.of(context).settings.arguments;
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
                    producto.name,
                    style: TextStyle(
                        color: Colors.red[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
                SizedBox(height: 20),
                _productCard(context, producto),
                _cardsGroup(context)
              ],
            )
          ],
        ));
  }
}

Widget _productCard(context, ProductItem producto) {
  final mWidth = MediaQuery.of(context).size.width;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        margin: EdgeInsets.all(5),
        width: mWidth / 2.5,
        height: mWidth / 2.5,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, 4), blurRadius: 5)
          ],
          gradient: LinearGradient(
              colors: [Colors.grey[100], Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          borderRadius: BorderRadius.circular(mWidth / 5),
        ),
        child: Image.asset('fruta.png'),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: mWidth / 2.5,
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            width: mWidth / 2.5,
            alignment: Alignment.center,
            child: Text(
              'S/. ${producto.price}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red[900], fontSize: 20),
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(16)),
                child: IconButton(
                    icon: Icon(Icons.remove),
                    iconSize: 16,
                    color: Colors.red[900],
                    onPressed: () {}),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  alignment: Alignment.center,
                  width: 32,
                  height: 32,
                  child: Text(
                    '1',
                    style: TextStyle(color: Colors.red[900], fontSize: 20),
                  )),
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
                    onPressed: () {}),
              ),
            ],
          ),
        ],
      )
    ],
  );
}

Widget _cardsGroup(context) {
  final cards = ['INFORMACIÓN', 'SALUDABLE', 'MARCAS Y RPODUCCIÓN'];
  return Column(
      children: List.generate(cards.length, (index) {
    return _card(context, cards[index]);
  }));
}

Widget _card(context, String title) {
  final mWidth = MediaQuery.of(context).size.width;
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    padding: EdgeInsets.all(20),
    width: mWidth - 40,
    height: mWidth / 4,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 5.0,
          offset: Offset(0, 2.0), // shadow direction: bottom right
        )
      ],
      color: Colors.orange[100],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.red[900],
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.red[900],
            fontSize: 10,
          ),
        ),
      ],
    ),
  );
}
