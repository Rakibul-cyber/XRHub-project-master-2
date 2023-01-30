import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/pages/tasks/selectedtaskstate.dart';

class TaskReroute extends StatefulWidget {
  final AppState appState;
  final SelectedTaskState myindex;
  TaskReroute({this.appState, this.myindex, Key key}) : super(key: key);

  @override
  State<TaskReroute> createState() => _TaskRerouteState();
}

class _TaskRerouteState extends State<TaskReroute> {
  @override
  void initState() {
    // TODO: implement initState
    rereoute();
    super.initState();
  }

  void rereoute() {
    setState(() {
      widget.appState.selectedIndex = 11;
      widget.myindex.selectedTask = "case0003_080722";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: getnum(mynum()),
    );
  }

  Widget getnum(String mystring) {
    return CustomText(
      text: mystring,
    );
  }

  String mynum() {
    return widget.myindex.selectedTask;
  }

  Widget reloadbtn() {
    return ElevatedButton(
        onPressed: () {
          widget.appState.selectedIndex = 11;
          widget.myindex.selectedTask = "case0003_080722";
        },
        child: CustomText(
          text: "RELOAD",
        ));
  }
}
