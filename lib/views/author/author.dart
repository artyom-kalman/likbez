import 'package:flutter/material.dart';
import 'package:likbez/theme/colors.dart';
import 'package:likbez/theme/title.dart';
import 'package:likbez/views/author/author_card.dart';
import 'package:likbez/views/author/biography.dart';
import 'package:likbez/widgets/books_scroll.dart';

class Author extends StatelessWidget {
    const Author({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: black,
                title: title
            ),
            body: Container(
                decoration: const BoxDecoration(
                    color: bgColor,
                ),
                child: ListView(
                    children: const <Widget>[
                        AuthorCard(),
                        Biography(),
                        BooksScroll('Произведения'),
                    ],
                ),
            )
        );
    }
}

