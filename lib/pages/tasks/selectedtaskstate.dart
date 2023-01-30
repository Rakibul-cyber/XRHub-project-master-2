import 'package:flutter/material.dart';

class SelectedTaskState extends ChangeNotifier {
  String _selectedTask;

  final List<String> taskindex = [];

  get selectedTask => _selectedTask;

  set selectedTask(String task) {
    _selectedTask = task;
    notifyListeners();
  }

  int getSelectedTaskById() {
    if (!taskindex.contains(_selectedTask)) return 0;
    return taskindex.indexOf(_selectedTask);
  }

  void setSelectedTaskById(int id) {
    if (id < 0 || id > taskindex.length - 1) {
      return;
    }

    _selectedTask = taskindex[id];
    notifyListeners();
  }
}
