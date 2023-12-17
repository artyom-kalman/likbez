import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:epub_view/epub_view.dart';


class EpubScreen extends StatefulWidget {
    final Uint8List data;

    const EpubScreen({super.key, required this.data});

    @override
    EpubScreenState createState() => EpubScreenState();
}

class EpubScreenState extends State<EpubScreen> with WidgetsBindingObserver {
    late EpubController _epubController;

    @override
    void initState() {
        super.initState();
        _epubController = EpubController(
            // Load document
            document: EpubDocument.openData(widget.data),
            // Set start point
            epubCfi: 'epubcfi(/6/6[chapter-2]!/4/2/1612)',
        );
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            // Show actual chapter name
            title: EpubViewActualChapter(
                controller: _epubController,
                builder: (chapterValue) => Text(
                    // TODO: Выводить название
                    'Название',
                    textAlign: TextAlign.start,
                )
            ),
        ),
        drawer: Drawer(
            child: EpubViewTableOfContents(
                controller: _epubController,
            ),
        ),
        body: EpubView(
            controller: _epubController,
        ),
    );
}