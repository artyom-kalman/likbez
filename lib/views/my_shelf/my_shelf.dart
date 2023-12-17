import 'dart:async';
import 'dart:io';

import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:likbez/views/epub_screen/epub_screen.dart';
import 'package:likbez/views/pdf_screen/pdf_screen.dart';
import 'package:likbez/utils/types/book_description.dart';
import 'package:likbez/utils/constants/boxes.dart';

import 'package:hive/hive.dart';
import 'package:path/path.dart' as p;
import 'package:image/image.dart' as img;
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

const booksCounterName = 'booksCounter';


class MyShelf extends StatefulWidget {
    const MyShelf({super.key});

    @override
    MyShelfState createState() => MyShelfState();
}

class MyShelfState extends State<MyShelf> {
    late Future<int> _booksCounter;

    final _prefs = SharedPreferences.getInstance();

    late Box<Uint8List> booksContentBox;
    late Box<BookDescription> bookDescriptionBox;

    @override
    void initState() {
        super.initState();
        booksContentBox = Hive.box(Boxes.booksContentBoxName.value);
        bookDescriptionBox = Hive.box(Boxes.booksDescriptionBoxName.value);
        
        _booksCounter = _prefs.then((prefs) {
            return prefs.getInt('counter') ?? 0;
        });
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Flutter PDF View',
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                appBar: AppBar(
                    title: const Text('Plugin example app'),
                    actions: <Widget>[
                        IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () => clearDB()
                        ),
                    ]
                ),

                body: Builder(
                    builder: (context) {
                        final box = bookDescriptionBox;
                        return ListView.builder(
                            itemCount: box.length,
                            itemBuilder: (context, index) {
                                final book = box.getAt(index)!;
                                
                                return ListTile(
                                    title: Text(book.name),
                                    subtitle: Text('Автор: ${book.author}\nType: ${book.type}'),
                                    
                                    onTap: () {
                                        final bookId = book.bookId;
                                        final type = book.type;
                                        final bookContent = booksContentBox.get(bookId)!;
                                        print('fbdfbdfbd $type');

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                                    if(type == '.epub') {
                                                        return EpubScreen(data: bookContent);
                                                    }

                                                    return PDFScreen(data: bookContent);
                                                }
                                            ),
                                        );
                                    },
                                );
                            },
                        );
                    }
                ),

                floatingActionButton: FloatingActionButton(
                    shape: const CircleBorder(),
                    tooltip: "Add book",

                    onPressed: () async {
                        final isPermissionGranted = await permissionHandler();

                        if(!isPermissionGranted) {
                            return;
                        }

                        final result = await FilePicker.platform.pickFiles();
                        if(result == null) {
                            // TODO: 
                            return;
                        }

                        final file = File(result.files.single.path!);
                        await addNewBook(file);


                        // Проверка загрузки
                        final count = await _booksCounter;
                        final uintContent = booksContentBox.get(count);
                        // print(count);
                        // print(uintContent);
                        print(bookDescriptionBox.get(count));
                    },

                    child: const Icon(Icons.add),
                ),
            ),
        );
    }

    double getProgress(int currentValue, int totalValue) {
        return currentValue / totalValue * 100;
    }

    Map<dynamic, BookDescription> getBooks() {
        return bookDescriptionBox.toMap();
    }

    void clearDB() async {
        await bookDescriptionBox.clear();
        await booksContentBox.clear();
        setState(() {
          
        });
    }

    Future<bool> permissionHandler() async {
        const permission = Permission.photos;

        if (await permission.isDenied) {
            final requestResult = await permission.request();

            if(!requestResult.isGranted) {
                // TODO: Обработка отказа
                return false;
            }
        }
        return true;
    }

    Future<int> _incrementCounter() async {
        final SharedPreferences prefs = await _prefs;

        final previousCounterValue = prefs.getInt(booksCounterName) ?? 0;
        final newCounterValue = previousCounterValue + 1;
        
        await prefs.setInt(booksCounterName, newCounterValue);

        setState(() {
            _booksCounter = prefs.setInt(booksCounterName, newCounterValue)
                .then((bool success) {
                    return newCounterValue;
                });
        });

        return newCounterValue;
    }

    Future<void> addNewBook(File file) async {
        final newBookId = await _incrementCounter();
        var author = 'Автор';
        var title = 'Название';
        img.Image? cover;

        final newBookContent = file.readAsBytesSync();

        String fileExtension = p.extension(file.path);

        if (fileExtension == '.epub') {
            final epubBook = await EpubReader.readBook(newBookContent);
            author = epubBook.Author!;
            title = epubBook.Title!;
            cover = epubBook.CoverImage;
            // cover.

            // cover = epubBook.CoverImage!;
            // pagesTotal = epubBook.Content
        }

        final newBookDescription = BookDescription(
            bookId: newBookId,
            name: title,
            author: author,
            pagesTotal: 5,
            type: fileExtension,
        );

        booksContentBox.put(newBookId, newBookContent);
        bookDescriptionBox.put(newBookId, newBookDescription);
    }
}

