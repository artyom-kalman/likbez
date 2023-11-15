import 'package:flutter/material.dart';

Color bgColor = Color.fromARGB(255, 12, 12, 12);
Color black   = Color.fromARGB(255, 0, 0, 0);
Color red     = Color.fromARGB(255, 234, 32, 40);
Color orange  = Color.fromARGB(255, 238, 82, 20);
Color white   = Color.fromARGB(255, 255, 255, 255);

var myTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bgColor,
    textTheme: TextTheme(
        bodyMedium: TextStyle(color: white),
    )
);