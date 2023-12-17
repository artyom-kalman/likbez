import 'package:flutter/material.dart';
import 'package:likbez/views/book/book.dart';
import 'package:likbez/views/books.dart';
import 'package:likbez/views/author/author.dart';
import 'package:likbez/views/my_shelf/my_shelf.dart';
import 'theme/theme.dart';

class Likbez extends StatelessWidget {
    const Likbez({super.key});

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'ЛизБез',
            home: MyShelf(),
            theme: myTheme,
        );
    }
}