import 'package:flutter/material.dart';
import 'package:likbez/theme/colors.dart';
import 'package:likbez/theme/title.dart';
import 'package:likbez/widgets/books_scroll.dart';

class Books extends StatelessWidget {
    const Books({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: black,
                title: const Text('Книги'),
            ),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                    Container(
                        decoration: const BoxDecoration(
                            color: bgColor
                        ),
                        child: const Text('АВТОРЫ'),
                    ),
                    Container(
                        decoration: const BoxDecoration(
                            color: bgColor
                        ),
                        child: const Text('ЖАНРЫ'),
                    ),
                    Container(
                        decoration: const BoxDecoration(
                            color: bgColor
                        ),
                        child: const Text('КАТЕГОРИИ'),
                    ),
              ],
            )
        );
    }
}