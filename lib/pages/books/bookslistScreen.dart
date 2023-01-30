import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/pages/books/book.dart';
import 'package:urlnav2/pages/books/selectedBookState.dart';

// Screens
class BooksListScreen extends StatelessWidget {
  final SelectedBookState bookState;

  BooksListScreen({this.bookState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          for (var book in bookState.books)
            ListTile(
                title: Text(book.title),
                subtitle: Text(book.author),
                onTap: () {
                  bookState.selectedBook = book;
                })
        ],
      ),
    );
  }
}
/*ListTile(
  title: Text(book.title),
  subtitle: Text(book.author),
  onTap: ()=> onTapped(book),)*/