import 'package:flutter/material.dart';
import 'package:likbez/theme/colors.dart';

class BookPreview extends StatelessWidget {
    final String title;

    const BookPreview(this.title, {super.key});

    @override
    Widget build(BuildContext context){
        return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 100,
            height: 100,
            child: Column(
                children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(5)
                        ),
                        child: Image.asset(
                            'images/cover.jpg',
                        ),
                    ),
                    Text(title),
                ],
            ),
        );
    }
}