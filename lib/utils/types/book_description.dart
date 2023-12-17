import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class BookDescription extends HiveObject {
    @HiveField(0)
    late int bookId;

    @HiveField(1)
    String name;

    @HiveField(2)
    String author;

    @HiveField(3)
    late int? currentPage;

    @HiveField(4)
    int? pagesTotal;

    @HiveField(5)
    String? type;


    BookDescription({required this.bookId, required this.name, required this.author, this.pagesTotal, this.type}) {
        currentPage = 0;
    }

    BookDescription.fromBox({required this.bookId, required this.name, required this.author, this.currentPage, this.pagesTotal, this.type});
 
    @override
    String toString() {
        return '$bookId | $name | $author | $type | $currentPage/$pagesTotal';
    }
}