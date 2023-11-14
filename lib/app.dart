import 'package:flutter/material.dart';
import 'package:likbez/views/books.dart';
import 'package:likbez/views/author.dart';
import 'theme/theme.dart';

class Likbez extends StatelessWidget {
    const Likbez({super.key});

    @override
    Widget build(BuildContext context) {
        return const MaterialApp(
            title: 'ЛизБез',
            home: Author(),
        );
    }
}