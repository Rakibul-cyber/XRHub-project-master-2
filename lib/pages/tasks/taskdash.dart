import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/pages/cases/dashboard/cases_dashboard.dart';
import 'package:urlnav2/pages/cases/selectedCaseState.dart';
import 'package:urlnav2/pages/tasks/selectedtaskstate.dart';
import 'package:urlnav2/pages/tasks/widget/taskdashnew.dart';

class TaskDashScreen extends StatelessWidget {
  final SelectedTaskState myindex;
  final AppState appState;

  TaskDashScreen({Key key, this.myindex, this.appState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(paddingMain),
            child: TaskDashNew(
              selectedTaskState: myindex,
              appState: appState,
            ),
          ),
        ],
      ),
    );
  }
}
