import 'dart:math';
import 'package:flutter/material.dart';

Widget background(context) {
  final mediaSize = MediaQuery.of(context).size;
  Random h = new Random();
  List<double> alturas = [];
  for (var i = 0; i < 33; i++) {
    alturas.add(h.nextDouble() * 30 + 10);
  }
  return Container(
    color: Colors.orange[50],
    child: Column(
      children: [
        _colorBars(mediaSize.width, 'top', alturas),
        SizedBox(height: mediaSize.height - 80 - 80),
        _colorBars(mediaSize.width, 'down', alturas)
      ],
    ),
  );
}

Widget _colorBars(double mWidth, String position, List<double> alturas) {
  return Container(
    height: 40,
    child: Row(
        crossAxisAlignment: position == 'top'
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: List.generate(33, (index) {
          return Container(
              color: Color.fromRGBO(
                  index < 7
                      ? 255
                      : (index < 13
                          ? 255 - 40 * (index - 7)
                          : (index < 27 ? 0 : 40 * (index - 27))),
                  index < 7
                      ? 40 * index
                      : (index < 20
                          ? 255
                          : (index < 27 ? 255 - 40 * (index - 20) : 0)),
                  index < 13
                      ? 0
                      : (index < 20
                          ? 40 * (index - 13)
                          : (index < 27 ? 255 : 255 - 40 * (index - 27))),
                  1.0),
              height: alturas[index],
              width: mWidth / 33);
        })),
  );
}
