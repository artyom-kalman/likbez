import 'package:hive_flutter/adapters.dart';
import 'package:likbez/utils/types/book_description.dart';

class BookDescriptionAdapter extends TypeAdapter<BookDescription> {
  @override
  final typeId = 0;

  @override
  BookDescription read(BinaryReader reader) {
    final bookId = reader.read();
    final name = reader.read();
    final author = reader.read();
    final currentPage = reader.read();
    final pagesTotal = reader.read();
    final type = reader.read();

    return BookDescription.fromBox(
        bookId: bookId,
        name: name,
        author: author,
        currentPage: currentPage,
        pagesTotal: pagesTotal,
        type: type,
    );
  }

  @override
  void write(BinaryWriter writer, BookDescription obj) {
    writer.write(obj.bookId);
    writer.write(obj.name);
    writer.write(obj.author);
    writer.write(obj.currentPage);
    writer.write(obj.pagesTotal);
    writer.write(obj.type);
  }
}