import 'package:hive/hive.dart';
import 'package:image/image.dart' show Image;

@HiveType(typeId: 0)
class BookDescription extends HiveObject {
    @HiveField(0)
    late int bookId;

    @HiveField(1)
    String name;

    @HiveField(2)
    String author;

    @HiveField(3)
    late int currentPage;

    @HiveField(4)
    late int pagesTotal;

    @HiveField(5)
    String? type;

    int get progress {
        return (currentPage / pagesTotal * 100).round();
    }


    BookDescription({required this.bookId, required this.name, required this.author, this.type}) {
        currentPage = 0;
        pagesTotal = 1;
    }

    BookDescription.fromBox({required this.bookId, required this.name, required this.author, required this.currentPage, required this.pagesTotal, this.type});
 
    @override
    String toString() {
        return '$bookId | $name | $author | $type | $currentPage/$pagesTotal';
    }
}