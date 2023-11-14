import 'package:flutter/material.dart';
import 'package:likbez/theme/colors.dart';
import 'package:likbez/theme/title.dart';
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
            body: ListView(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                    authorHeader,
                    biographySection,
                    BooksScroll('Произведения'),
              ],
            )
        );
    }
}

Widget biographySection = Container(
    padding: const EdgeInsets.all(32),
    child: const Column(
        children: [
            Text('Биография'),
            Text(
                'Агата Кристи (полное имя: Агата Мэри Кларисса Маллоуэн, урожденная Миллер) — '
                'английская писательница. Агата Миллер родилась 15 сентября 1890 года в городе '
                'Торки, графства Девон. Её родители были состоятельными переселенцами из '
                'Соединенных Штатов. Она была младшей дочерью в семье Миллеров.'
    ),
        ],
    )
);

Widget authorHeader = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
        Image.asset(
            'images/portrait.jpg',
        ),
        const Text('Агата Кристи'),
    ],
);