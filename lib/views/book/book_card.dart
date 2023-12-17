import 'package:flutter/material.dart';
import 'package:likbez/theme/colors.dart';

class BookCard extends StatelessWidget {
    const BookCard({super.key});



    @override
    Widget build(BuildContext context) {
        return Container(
            padding: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
                color: black, 
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                )
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    ClipRRect(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(10)
                        ),
                        child: 
                            Image.asset(
                                'images/cover.jpg',    
                            ),
                        ),
                    const Text('Дюна', style: TextStyle(color: white),),
                ],
            ),
        );
    }
}