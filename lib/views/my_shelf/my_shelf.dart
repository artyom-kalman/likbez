import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:likbez/theme/theme.dart';
import 'package:likbez/views/epub_screen/epub_screen.dart';
import 'package:likbez/views/my_shelf/edit_book_dialog.dart';
import 'package:likbez/views/pdf_screen/pdf_screen.dart';
import 'package:likbez/utils/types/book_description.dart';
import 'package:likbez/utils/constants/boxes.dart';

import 'package:hive/hive.dart';
import 'package:epub_view/epub_view.dart' show EpubReader;
import 'package:path/path.dart' show extension, basenameWithoutExtension;
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
    final _prefs = SharedPreferences.getInstance();

    // late Box<Uint8List> bookCoverBox;
    late Box<Uint8List> booksContentBox;
    late Box<BookDescription> bookDescriptionBox;

    @override
    void initState() {
        super.initState();
        // bookCoverBox        = Hive.box(Boxes.bookCoverBox.value);
        booksContentBox     = Hive.box(Boxes.booksContentBoxName.value);
        bookDescriptionBox  = Hive.box(Boxes.booksDescriptionBoxName.value);
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            theme: myTheme,
            title: 'Ликбез',
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                appBar: AppBar(
                    title: const Text('Моя полка'),
                    actions: <Widget>[
                        IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () => clearDB()
                        ),
                    ]
                ),

                body: Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListView.builder(
                        itemCount: bookDescriptionBox.length,
                        itemBuilder: (context, index) {
                            final book = bookDescriptionBox.getAt(index)!;
                            
                            return Card(
                                color: orange,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 8
                                ),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: white,
                                        width: 1
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: ListTile(
                                    textColor: white,
                                    title: Text(book.name),
                                    subtitle: Text('Автор: ${book.author}\nType: ${book.type}\n${book.progress}%'),
                                    
                                    horizontalTitleGap: 10,
                                    
                                    onTap: () {
                                        final bookId = book.bookId;
                                        final type = book.type;
                                        final bookContent = booksContentBox.get(bookId)!;

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                                    if(type == '.epub') {
                                                        print(book.currentPage);
                                                        return EpubScreen(data: bookContent, bookId: bookId,);
                                                    }

                                                    return PDFScreen(data: bookContent, bookId: bookId,);
                                                }
                                            ),
                                        );
                                        
                                    },

                                    onLongPress: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                                final editBookDialog = EditBookDialog(bookId: book.bookId);
                                                editBookDialog.bookDescriptionBox = bookDescriptionBox;
                                                editBookDialog.bookContentBox = booksContentBox;
                                                return editBookDialog;
                                            }
                                        ).then( (_) => 
                                            setState(() {} )
                                        );
                                           
                                    },
                                )
                            );
                        }
                    ),
                ),

                floatingActionButton: FloatingActionButton(
                    shape: const CircleBorder(),
                    tooltip: "Add book",
                    backgroundColor: orange,
                    foregroundColor: white,

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
                    },

                    child: const Icon(Icons.add),
                ),
            ),
        );
    }

    Map<dynamic, BookDescription> getBooks() {
        return bookDescriptionBox.toMap();
    }

    void clearDB() async {
        await bookDescriptionBox.clear();
        await booksContentBox.clear();
        setState(() {});
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

        return newCounterValue;
    }

    Future<void> addNewBook(File file) async {
        // Не получается сохранять и отображать обложку

        final newBookId = await _incrementCounter();
        var author = '-';
        var title = basenameWithoutExtension(file.path);
        // Uint8List cover = Uint8List(0);

        final newBookContent = file.readAsBytesSync();

        String fileExtension = extension(file.path);

        if (fileExtension == '.epub') {
            final epubBook = await EpubReader.readBook(newBookContent);
            author = epubBook.Author!;
            title = epubBook.Title!;
            // cover = epubBook.CoverImage!.getBytes();
        }

        final newBookDescription = BookDescription(
            bookId: newBookId,
            name: title,
            author: author,
            type: fileExtension
        );

        // bookCoverBox.put(newBookId, cover);
        booksContentBox.put(newBookId, newBookContent);
        bookDescriptionBox.put(newBookId, newBookDescription);
    }
}

