import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:faker_flutter/models/book_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'book_provider.g.dart';

@riverpod
Future<List<Book>> fetchBooks(ref) async {
  final response = await http
      .get(Uri.parse('https://fakerapi.it/api/v1/books?_quantity=10'));
  if (response.statusCode == 200) {
    List<Book> books = [];
    var data = jsonDecode(response.body);
    for (var book in data['data']) {
      books.add(Book.fromJson(book));
    }
    return books;
  } else {
    throw Exception('Failed to load books');
  }
}
