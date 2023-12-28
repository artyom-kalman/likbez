import 'package:flutter/material.dart';
import 'package:likbez/views/my_shelf/my_shelf.dart';
import 'theme/theme.dart';

class Likbez extends StatelessWidget {
    const Likbez({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'ЛизБез',
            home: const MyShelf(),
            theme: myTheme,
        );
    }
}