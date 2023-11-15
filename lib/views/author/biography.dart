import 'package:flutter/material.dart';
import 'package:likbez/theme/colors.dart';

class Biography extends StatelessWidget {
    const Biography({super.key});

    @override
    Widget build(BuildContext context) {
        return Container(
            padding: const EdgeInsets.all(32),
            child: const Column(
                children: [
                    Text(
                        'Биография',
                        style: TextStyle(color: white),
                    ),
                    Text(
                        'Агата Кристи (полное имя: Агата Мэри Кларисса Маллоуэн, урожденная Миллер) — '
                        'английская писательница. Агата Миллер родилась 15 сентября 1890 года в городе '
                        'Торки, графства Девон. Её родители были состоятельными переселенцами из '
                        'Соединенных Штатов. Она была младшей дочерью в семье Миллеров.',
                        style: TextStyle(color: white),
            ),
                ],
            )
        );
    }
}