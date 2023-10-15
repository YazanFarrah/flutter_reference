import 'package:flutter/material.dart';

const BoxDecoration myGradientBoxDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color.fromARGB(255, 71, 26, 150),
      Color.fromARGB(255, 103, 58, 183),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
);
