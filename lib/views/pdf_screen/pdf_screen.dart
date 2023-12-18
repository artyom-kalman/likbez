import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hive/hive.dart';
import 'package:likbez/utils/constants/boxes.dart';
import 'package:likbez/utils/types/book_description.dart';

class PDFScreen extends StatefulWidget {
    final Uint8List data;
    final int bookId;

    const PDFScreen({ super.key, required this.data, required this.bookId });

    @override
    PDFScreenState createState() => PDFScreenState();
}

class PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
    final _controller = Completer<PDFViewController>();

    int? pages = 0;
    int? currentPage;
    bool isReady = false;
    String errorMessage = '';

    late Box<BookDescription> bookDescriptionBox;

    @override
    void initState() {
        super.initState();

        bookDescriptionBox = Hive.box(Boxes.booksDescriptionBoxName.value);

        currentPage = bookDescriptionBox.get(widget.bookId)?.currentPage;
    }

    @override
    void dispose() {
        super.dispose();

        var book = bookDescriptionBox.get(widget.bookId)!;
        book.currentPage = currentPage!;
        book.pagesTotal = pages!;
        bookDescriptionBox.put(widget.bookId, book);
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("Document"),
            ),


            body: Stack(
                children: <Widget>[ 
                    PDFView(
                        pdfData: widget.data,
                        enableSwipe: true,
                        swipeHorizontal: true,
                        autoSpacing: false,
                        pageFling: true,
                        pageSnap: true,
                        defaultPage: currentPage!,
                        fitPolicy: FitPolicy.BOTH,
                        preventLinkNavigation: false,  
                        onRender: (_pages) {
                            setState(() {
                                pages = _pages;
                                isReady = true;
                            });
                        },
                        onError: (error) {
                            setState(() {
                                errorMessage = error.toString();
                            });
                            print(error.toString());
                        },
                        onPageError: (page, error) {
                            setState(() {
                                errorMessage = '$page: ${error.toString()}';
                            });
                            print('$page: ${error.toString()}');
                        },
                        onViewCreated: (PDFViewController pdfViewController) {
                            _controller.complete(pdfViewController);
                            pdfViewController.setPage(currentPage ?? 0);
                        },

                        onPageChanged: (int? page, int? total) {
                            print('page change: $page/$total');
                            setState(() {
                                currentPage = page;
                            });
                        },
                    ),
                ]
            ),
        );
    }
}