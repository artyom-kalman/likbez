import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:likbez/main.dart';
import 'package:likbez/utils/types/book_description.dart';

class EditBookDialog extends StatefulWidget {
    late final int bookId;
    late final Box<BookDescription> bookDescriptionBox;
    late final Box<Uint8List> bookContentBox;

    EditBookDialog({super.key, required this.bookId});

    @override
    EditBookDialogState createState () => EditBookDialogState();
}

class EditBookDialogState extends State<EditBookDialog> {
    final titleTbController = TextEditingController();
    final authorTbController = TextEditingController();

    late final BookDescription book;
    late final String currentAuthor;
    late final String currentTitle;

    @override 
    void initState() {
        super.initState();

        book = widget.bookDescriptionBox.get(widget.bookId)!;
        currentAuthor = book.author;
        currentTitle = book.name;

        titleTbController.text = currentTitle;
        authorTbController.text = currentAuthor;
    }

    @override
    void dispose() {
        titleTbController.dispose();
        authorTbController.dispose();

        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return AlertDialog(
            title: const Text('Реадктирование'),
            content: SizedBox(
                height: 100,
                child: Column(
                    children: [
                        TextField(
                            controller: titleTbController,
                            decoration: const InputDecoration(
                                hintText: "Название"
                            ),
                            
                        ),
                        TextField(
                            controller: authorTbController,
                            decoration: const InputDecoration(
                                hintText: "Автор"
                            ),
                        ),
                    ],
                )
            ),
            actions: <Widget>[
                TextButton(
                    child: const Text('Удалить'),
                    onPressed: () {
                        widget.bookDescriptionBox.delete(widget.bookId);
                        widget.bookContentBox.delete(widget.bookId);

                        Navigator.of(context).pop();
                    },
                ),
                TextButton(
                    child: const Text('Сохранить'),
                    onPressed: () {
                        book.author = authorTbController.text;
                        book.name = titleTbController.text;
                        widget.bookDescriptionBox.put(widget.bookId, book);

                        Navigator.of(context).pop();
                    },
                ),
            ],
        );
    }
}
