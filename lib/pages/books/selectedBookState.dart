import 'package:flutter/material.dart';
import 'package:urlnav2/pages/books/book.dart';
import 'package:urlnav2/appState.dart';

class SelectedBookState extends ChangeNotifier {
  Book _selectedBook;
  AppState appState = AppState();

  final List<Book> books = [
    Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
    Book('The Sun', 'Isaac Asimov'),
    Book('Steve Jobs', 'Walter Isaacson'),
  ];

  Book get selectedBook => _selectedBook;

  set selectedBook(Book book) {
    _selectedBook = book;
    notifyListeners();
  }

  int getSelectedBookById() {
    if (!books.contains(_selectedBook)) return 0;
    return books.indexOf(_selectedBook);
  }

  void setSelectedBookById(int id) {
    if (id < 0 || id > books.length - 1) {
      return;
    }

    if (appState.selectedIndex != 4) {
      _selectedBook = null;
    }

    _selectedBook = books[id];
    notifyListeners();
  }
}
