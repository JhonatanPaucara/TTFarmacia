import 'package:flutter/material.dart';
import 'package:ttfarmacia/utils/background.dart';

class Pharmacy extends StatefulWidget {
  Pharmacy({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _PharmacyState createState() => _PharmacyState();
}

class _PharmacyState extends State<Pharmacy> {
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
                    'THIKA THANI FARMACIA',
                    style: TextStyle(
                        color: Colors.red[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
                SizedBox(height: 20),
                _cardsGroup(context)
              ],
            )
          ],
        ));
  }
}

Widget _cardsGroup(context) {
  final cards = [
    'SUPER ALIMENTOS ANDINOS, COMPLEMENTOS Y SUPLEMENTOS NUTRICIONALES',
    'COSMÉTICA NATURAL Y CUIDADO PERSONAL'
  ];
  final productos1 = ['Super alimentos andinos', 'Complementos', 'Suplementos'];
  final productos2 = [
    'Jabones naturales',
    'Aceites naturales & cremas humectantes',
    'Cosmética natural',
    'Cuidado personal'
  ];
  final productos = [productos1, productos2];
  return Column(
      children: List.generate(cards.length, (index) {
    return _card(context, productos[index], cards[index]);
  }));
}

Widget _card(context, List<String> productos, String title) {
  final mWidth = MediaQuery.of(context).size.width;
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    padding: EdgeInsets.all(20),
    height: mWidth / 2.5,
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
          style: TextStyle(color: Colors.red[900], fontSize: 12),
        ),
        Row(
            children: List.generate(productos.length, (index) {
          return GestureDetector(
            onTap: () {
              if (productos[index] == 'Super alimentos andinos') {
                Navigator.pushNamed(context, 'productGroup');
              } else
                print(productos[index]);
            },
            child: Column(children: [
              Container(
                margin: EdgeInsets.all(5),
                width: mWidth / 6,
                height: mWidth / 6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(mWidth / 12),
                ),
                child: Image.asset('fruta.png'),
              ),
              Container(
                  width: mWidth / 6,
                  height: mWidth / 24,
                  child: Text(
                    productos[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red[900], fontSize: 8),
                  )),
            ]),
          );
        })),
      ],
    ),
  );
}
