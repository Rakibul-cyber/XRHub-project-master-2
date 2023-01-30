import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/myconstants.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/pages/tasks/selectedtaskstate.dart';

class TaskDashNew extends StatefulWidget {
  final SelectedTaskState selectedTaskState;
  final AppState appState;
  TaskDashNew({Key key, this.selectedTaskState, this.appState})
      : super(key: key);

  @override
  State<TaskDashNew> createState() => _TaskDashNewState();
}

class _TaskDashNewState extends State<TaskDashNew> {
  Stream<QuerySnapshot> tasks;

  @override
  void initState() {
    tasks = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('events')
        .snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Flexible(flex: 1, child: ongoingtasks2(1000, "IN PROGRESS")),
          x30,
          Flexible(flex: 1, child: ongoingtasks2(1000, "TO DO")),
          x30,
          Flexible(flex: 1, child: ongoingtasks2(1000, "COMPLETED")),
        ],
      ),
    );
  }

  Widget tasklist() {
    return CustomText(
      text: "Page ${widget.selectedTaskState.selectedTask}",
    );
  }

  Widget ongoingtasks2(double height, String title) {
    return StreamBuilder<QuerySnapshot>(
        stream: tasks,
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
          final data = snapshot.requireData;

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    color: lightGrey,
                    text: title,
                    weight: FontWeight.bold,
                  ),
                  Icon(Icons.add),
                ],
              ),
              ListView.builder(
                  itemCount: data.size,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return taskcell(data.docs[index]['eventtitle'], "category",
                        data.docs[index]['eventdesc'], "12-12-22");
                  }),
            ],
          );
        });
  }

  Widget taskcell(
      String task, String category, String summary, String duedate) {
    return InkWell(
      onHover: (value) {},
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(paddingMid),
        width: MediaQuery.of(context).size.width,
        //padding: const EdgeInsets.all(paddingMid),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 6),
                  color: lightGrey.withOpacity(0.4),
                  blurRadius: 5)
            ],
            color: legistwhite,
            //border: Border.all(color: lightGrey, width: .5),
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(paddingMid),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(space_20)),
                    child: CustomText(
                      text: category,
                      color: legistwhitefont,
                      size: 10,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.more_horiz_outlined,
                      color: lightGrey,
                    ),
                  ),
                ],
              ),
              CustomText(
                text: task,
                weight: FontWeight.bold,
              ),
              CustomText(
                text: summary,
                color: lightGrey,
                size: 12,
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                leading: Icon(
                  Icons.date_range_outlined,
                  color: lightGrey,
                ),
                title: CustomText(
                  text: duedate,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.person_outline,
                    color: lightGrey,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.attach_file,
                        color: lightGrey,
                      ),
                      CustomText(
                        text: "5",
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
