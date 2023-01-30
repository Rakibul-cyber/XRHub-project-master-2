import 'package:flutter/material.dart';

class SelectedCaseState extends ChangeNotifier {
  int _selectedCase;

  //SelectedCaseState() : _selectedCase = 1;

  final List<int> caseindex = [0, 1, 2, 3, 4, 5, 6, 7];

  int get selectedCase => _selectedCase;

  set selectedCase(int book) {
    _selectedCase = book;
    notifyListeners();
  }

  int getSelectedCaseById() {
    if (!caseindex.contains(_selectedCase)) return 0;
    return caseindex.indexOf(_selectedCase);
  }

  void setSelectedCaseById(int id) {
    if (id < 0 || id > caseindex.length - 1) {
      return;
    }

    _selectedCase = caseindex[id];
    notifyListeners();
  }
}
