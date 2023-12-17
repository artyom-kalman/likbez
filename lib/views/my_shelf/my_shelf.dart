import 'package:flutter/material.dart';
import 'package:likbez/theme/colors.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class MyShelf extends StatelessWidget {


    @override
    Widget build (BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('ЛикБез'),
                backgroundColor: black,
            ),
            body: PDFView(
                filePath: './.books/test.pdf'
            ),
        );
    }
}