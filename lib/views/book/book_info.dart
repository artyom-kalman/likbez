import 'package:flutter/material.dart';
import 'package:likbez/theme/colors.dart';

class BookInfo extends StatelessWidget {
    const BookInfo({super.key});

    @override
    Widget build(BuildContext context) {
        return Container(
            padding: const EdgeInsets.all(32),
            child: const Column(
                children: [
                    Text(
                        'Описание',
                        style: TextStyle(color: white),
                    ),
                    Text(
                        'Описание книги',
                        style: TextStyle(color: white),
            ),
                ],
            )
        );
    }
}