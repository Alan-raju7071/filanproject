import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/Bookmodels.dart';
import 'package:http/http.dart' as http;



class BookController with ChangeNotifier {
  List<Book> books = [];
  bool isLoading = false;
  String errorMessage = '';

  BookController() {
    loadDefaultBooks();
  }

  Future<void> loadDefaultBooks() async {
    await searchBooks('wind');
  }

  Future<void> searchBooks(String query) async {
    isLoading = true;
    errorMessage = '';
    books = [];
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List items = data['items'] ?? [];

        books = items.map((item) => Book.fromJson(item)).toList();

        if (books.isEmpty) {
          errorMessage = 'No books found.';
        }
      } else {
        errorMessage = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage = 'Something went wrong. Please try again.';
    }

    isLoading = false;
    notifyListeners();
  }
}
