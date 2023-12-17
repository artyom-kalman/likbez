import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFScreen extends StatefulWidget {
    final Uint8List data;

    const PDFScreen({ super.key, required this.data });

    @override
    PDFScreenState createState() => PDFScreenState();
}

class PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
    final _controller = Completer<PDFViewController>();
    int? pages = 0;
    int? currentPage = 0;
    bool isReady = false;
    String errorMessage = '';

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
                        },
                        onPageChanged: (int? page, int? total) {
                            print('page change: $page/$total');
                            setState(() {
                                currentPage = page;
                            });
                        },
                    ),

                    // TODO
                    errorMessage.isEmpty
                        ? !isReady
                            ? Center(
                                child: CircularProgressIndicator(),
                                )
                            : Container()
                        : Center(
                            child: Text(errorMessage),
                            )
                    ],
                ),
        );
    }
}