import 'package:flutter/material.dart';
import 'package:likbez/theme/colors.dart';
import 'package:likbez/widgets/book_preview.dart';

class BooksScroll extends StatelessWidget {
    final String title;

    const BooksScroll(this.title, {super.key});

    @override
    Widget build(BuildContext context) {
        return Container(
            // TODO: Изменить отступы
            padding: EdgeInsets.symmetric(horizontal: 20),

            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                        title,
                        style: const TextStyle(color: white),
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 20.0),
                        height: 200.0,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: const <Widget>[
                                BookPreview('Дюна'),
                                BookPreview('Дюна'),
                                BookPreview('Дюна'),
                                BookPreview('Дюна'),
                                BookPreview('Дюна'),
                            ],
                        ),
                    ),
                ],
            ),
        );
    }
}