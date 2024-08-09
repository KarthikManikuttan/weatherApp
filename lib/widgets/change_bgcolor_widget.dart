import 'package:flutter/material.dart';

int time = DateTime.now().hour;

List<Color> gradientColor = time > 18 || time < 7
    ? [Color(0xff16222a), Color(0xff3a6073), Color(0xff16222a)]
    : [Color(0xff004dbf), Color(0xff4364f7), Color(0xff6fb1fc)];

BoxDecoration decoration = BoxDecoration(
  gradient: LinearGradient(
    colors: gradientColor,
    stops: [0.01, 0.2, 0.5],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
);
