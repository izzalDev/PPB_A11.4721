import 'dart:convert';
//untuk mengakses file assets
import 'package:flutter/services.dart';
import 'book_model.dart';

class BookServices {
  static Future<List<BookModel>> getBooksFromJSON() async {
    try {
      final result =
          jsonDecode(await rootBundle.loadString('assets/book.json')) as List;
      return result.map((book) => BookModel.fromJSON(book)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
