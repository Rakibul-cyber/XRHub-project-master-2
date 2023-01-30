import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/myconstants.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/pages/tasks/selectedtaskstate.dart';

class TaskScreen extends StatefulWidget {
  final SelectedTaskState selectedTaskState;
  final AppState appState;
  TaskScreen({Key key, this.appState, this.selectedTaskState})
      : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  Stream<QuerySnapshot> cases;

  @override
  void initState() {
    cases = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('tasks')
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: cases,
          builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.data.docs.isEmpty) {
              return Center(
                child: ElevatedButton(
                    onPressed: () {
                      sideMenuController.changeActiveItemTo("Add New Case");
                      widget.appState.selectedIndex = 7;
                    },
                    child: CustomText(
                      text: "Please Add a Case",
                    )),
              );
            }
            final data = snapshot.requireData;
            return Column(
              children: [
                caseslist(context, data),
              ],
            );
          }),
    );
  }

  Widget caseslist(BuildContext context, QuerySnapshot<Object> data) {
    return Expanded(
        child: GridView.builder(
      itemCount: data.size,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1,
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
        crossAxisCount: ResponsiveWidget.isLargeScreen(context)
            ? 6
            : ResponsiveWidget.isMediumScreen(context)
                ? 4
                : 2,
      ),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: mytaskcase(
            data.docs[index]['case'], data.docs[index]['num'], index),
      ),
    ));
  }

  Widget mytaskcase(String titlename, String casenum, int index) {
    return InkWell(
      onTap: () {
        sideMenuController.changeActiveItemTo("Task#$index");
        widget.selectedTaskState.selectedTask = casenum;
      },
      radius: 15,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: legistwhite,
          border: Border.all(color: lightGrey, width: .5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12)
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: titlename,
              color: legistblue,
              weight: FontWeight.bold,
              talign: TextAlign.center,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "In Progress",
                      talign: TextAlign.center,
                    ),
                    getcount(casenum, 0),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "To Do",
                      talign: TextAlign.center,
                    ),
                    getcount(casenum, 1),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Completed",
                      talign: TextAlign.center,
                    ),
                    getcount(casenum, 2),
                  ],
                )
              ],
            ),
            Container()
          ],
        ),
      ),
    );
  }

  Widget getcount(String casenum, int status) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.appState.myid)
            .collection('tasks')
            .doc(casenum)
            .collection('taskscol')
            .where('status', isEqualTo: status)
            .snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final data = snapshot.requireData;

          return CustomText(
            text: data.size.toString(),
            talign: TextAlign.center,
          );
        });
  }
}
