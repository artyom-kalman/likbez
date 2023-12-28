import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:likbez/app.dart';
import 'package:likbez/utils/constants/boxes.dart';
import 'package:likbez/utils/types/book_description.dart';
import 'package:likbez/utils/adapters/book_description_adapter.dart';

const title = Text('Ликбез');

void main() async {
    await Hive.initFlutter();
    
    Hive.registerAdapter(BookDescriptionAdapter());

    // await Hive.openBox<Uint8List>(Boxes.bookCoverBox.value);
    await Hive.openBox<Uint8List>(Boxes.booksContentBoxName.value);
    await Hive.openBox<BookDescription>(Boxes.booksDescriptionBoxName.value);

    runApp(const Likbez());
}
