import 'dart:math';
import 'package:flutter/material.dart';

Widget background(context) {
  final mWidth = MediaQuery.of(context).size.width;
  return Container(
    color: Colors.orange[50],
    child: Column(
      children: [
        SizedBox(
          height: 54,
        ),
        Container(
            width: mWidth,
            child: Transform(
                transform: Matrix4.rotationX(pi),
                child: Image.asset('colors_bars.png'))),
        Expanded(child: SizedBox()),
        Container(width: mWidth, child: Image.asset('colors_bars.png')),
      ],
    ),
  );
}
