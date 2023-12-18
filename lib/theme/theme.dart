import 'package:flutter/material.dart';

Color bgColor = const Color.fromARGB(255, 30, 30, 30);
Color black   = const Color.fromARGB(255, 0, 0, 0);
Color red     = const Color.fromARGB(255, 234, 32, 40);
Color orange  = const Color.fromARGB(255, 238, 82, 20);
Color white   = const Color.fromARGB(255, 255, 255, 255);

var myTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bgColor,
    appBarTheme: AppBarTheme(
        color: black,
    )

);