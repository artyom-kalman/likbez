import 'package:flutter/material.dart';

class BooksScroll extends StatelessWidget {
    final String title;

    const BooksScroll(this.title, {super.key});

    @override
    Widget build(BuildContext context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(title),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    height: 200.0,
                    child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                            bookPreview,
                            bookPreview,
                            bookPreview,
                            bookPreview,
                        ],
                    ),
                ),
            ],
        );
    }
}

Widget bookPreview = SizedBox(
    width: 600,
    height: 400,
    child: Column(
        children: [
            Image.asset(
                'images/cover.jpg',
                height: 600,
                width: 100,
            ),
            Text('Дюна'),
        ],
    ),
);