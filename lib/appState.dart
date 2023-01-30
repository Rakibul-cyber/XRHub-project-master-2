import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int _selectedIndex;

  AppState() : _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  String get myid {
    User user = FirebaseAuth.instance.currentUser;
    return user.uid;
  }

  set selectedIndex(int idx) {
    _selectedIndex = idx;
    if (_selectedIndex != 4) {
      //_selectedBook = null;
    }
    notifyListeners();
  }

  /*Book _selectedBook;

  final List<Book> books = [
    Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
    Book('Foundation', 'Isaac Asimov'),
    Book('Fahrenheit 451', 'Ray Bradbury'),
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

    _selectedBook = books[id];
    notifyListeners();
  }*/
}
