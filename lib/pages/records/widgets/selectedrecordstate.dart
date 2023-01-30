import 'package:flutter/material.dart';

class SelectedRecordState extends ChangeNotifier {
  String _selectedrecord;

  final List<String> recordindex = ["0", "1", "2", "3", "4"];

  get selectedrecord => _selectedrecord;

  set selectedrecord(String record) {
    _selectedrecord = record;
    notifyListeners();
  }

  int getSelectedrecordById() {
    if (!recordindex.contains(_selectedrecord)) return 0;
    return recordindex.indexOf(_selectedrecord);
  }

  void setSelectedrecordById(int id) {
    if (id < 0 || id > recordindex.length - 1) {
      return;
    }

    _selectedrecord = recordindex[id];
    notifyListeners();
  }
}
