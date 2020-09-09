import 'package:flutter/material.dart';
import 'package:ttfarmacia/utils/background.dart';
import 'dart:math' as math;

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                _iconBar(),
                SizedBox(height: 20),
                _searchBar(),
                _flor(context),
                SizedBox(height: 20),
                Text('PRODUCTOS DESTACADOS',
                    style: TextStyle(
                        color: Colors.red[900], fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                _destacados(context)
              ],
            )
          ],
        ));
  }
}

Widget _destacados(context) {
  final mWidth = MediaQuery.of(context).size.width;
  List<String> litems = [
    "Salsas picantes",
    "Complementos nutricionales",
    "Barra energética",
    "Postres"
  ];
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            print('back');
          }),
      Container(
        width: 300,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(4, (index) {
              return Column(
                children: [
                  Container(
                    width: mWidth / 4.5,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.grey[300], Colors.white],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    height: mWidth / 4,
                    child: Image.asset('fruta.png'),
                  ),
                  Container(
                    width: mWidth / 4.5,
                    margin: EdgeInsets.all(5),
                    height: mWidth / 12,
                    child: Text(
                      litems[index],
                      style: TextStyle(
                          color: Colors.red[900], fontSize: mWidth / 36),
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
      IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: () {
            print('next');
          })
    ],
  );
}

Widget _iconBar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.red[900],
            size: 40,
          ),
          onPressed: null),
      IconButton(
          icon: Icon(Icons.card_giftcard, color: Colors.red[900], size: 40),
          onPressed: null),
      IconButton(
          icon: Icon(Icons.person_outline, color: Colors.red[900], size: 40),
          onPressed: null),
    ],
  );
}

Widget _searchBar() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 50.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.purple[100],
    ),
    child: TextField(
        decoration: InputDecoration(
      prefixIcon: Icon(Icons.search),
      hintText: 'Search',
    )),
  );
}

Widget _flor(context) {
  final mWidth = MediaQuery.of(context).size.width;
  return Stack(
    children: [
      Center(
        child: Stack(
            children: List.generate(8, (index) {
          return _petalo(
              Color.fromRGBO(
                  index < 2
                      ? 255
                      : (index < 3
                          ? 255 - 120 * (index - 2)
                          : (index < 6 ? 0 : 120 * (index - 5))),
                  index < 2
                      ? 120 * index
                      : (index < 5
                          ? 255
                          : (index < 6 ? 255 - 120 * (index - 6) : 0)),
                  index < 3
                      ? 0
                      : (index < 5
                          ? 120 * (index - 3)
                          : (index < 6 ? 255 : 255 - 120 * (index - 6))),
                  1.0),
              (7 - index) * math.pi / 4,
              context,
              index);
        })),
      ),
      Center(
          child: Column(
        children: [
          SizedBox(
            height: mWidth / 9,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (j) {
                      return Container(
                        height: ((i + 1) % 2) * 3 * mWidth / 40 + mWidth / 8,
                        width: ((j + 1) % 2) * 3 * mWidth / 40 + mWidth / 8,
                        child: FlatButton(
                            onPressed: () {
                              if (i == 0 && j == 2) {
                                Navigator.pushNamed(context, 'pharmacy');
                              } else
                                print('hola ${i * 3 + j + 1}');
                            },
                            child: Icon(Icons.account_circle)),
                      );
                    }));
              })),
        ],
      ))
    ],
  );
}

Widget _petalo(Color color, double angle, context, int i) {
  final mediaSize = MediaQuery.of(context).size;
  return Transform.rotate(
    angle: angle,
    origin: Offset(0, mediaSize.width / 4),
    child: Stack(
      children: [
        Transform.translate(
            offset: Offset(mediaSize.width / 16, 0),
            child: _medioPetalo(math.pi, math.pi / 3, color, context)),
        Transform.translate(
            offset: Offset(-mediaSize.width / 16, 0),
            child: _medioPetalo(0, -math.pi / 3, color, context)),
        /*Transform.translate(
          offset: Offset(mediaSize.width / 40, 0 * mediaSize.width / 8),
          child: FlatButton(
              color: Colors.blue,
              child: Text(''),
              onPressed: () {
                print('petalo $i');
              }),
        ),*/
      ],
    ),
  );
}

Widget _medioPetalo(
    double startAngle, double sweepAngle, Color color, context) {
  return CustomPaint(
    size: Size(MediaQuery.of(context).size.width * 0.25,
        MediaQuery.of(context).size.width * 0.25),
    painter:
        MyPainter(startAngle: startAngle, sweepAngle: sweepAngle, color: color),
  );
}

class MyPainter extends CustomPainter {
  MyPainter({this.startAngle, this.sweepAngle, this.color});
  final Color color;
  final double startAngle;
  final double sweepAngle;
  @override
  void paint(Canvas canvas, Size size) {
    final rect =
        Rect.fromLTRB(0, size.width / 4, size.width, 6 * size.width / 4);
    final startAngle = this.startAngle;
    final sweepAngle = this.sweepAngle;
    final useCenter = false;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}
