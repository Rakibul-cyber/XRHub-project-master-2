import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/pages/cases/dashboard/widget/case_task.dart';

class OnGoingCases extends StatefulWidget {
  final AppState appState;
  final int caseNo;
  OnGoingCases({Key key, this.appState, this.caseNo}) : super(key: key);

  @override
  State<OnGoingCases> createState() => _OnGoingCasesState();
}

class _OnGoingCasesState extends State<OnGoingCases> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.appState.myid)
            .collection('cases')
            .snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data.docs.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return mydata(data);
        });
  }

  Widget mydata(QuerySnapshot data) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ongoingcases(300, "Ongoing", 0, 'case0003_120722', data),
          x20,
          ongoingcases(300, "Due", 1, 'case0003_120722', data),
          x20,
          ongoingcases(300, "Completed", 2, 'case0003_120722', data),
        ],
      ),
    );
  }

  Widget ongoingcases2(String title, int myindex) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(paddingMid),
        decoration: BoxDecoration(
            border: Border.all(color: lightGrey), color: Colors.white),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: GoogleFonts.getFont('Poppins',
                        textStyle: const TextStyle(
                            fontSize: fontHeader, color: dark))),
                x10,
                if (ResponsiveWidget.isLargeScreen(context))
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: foregroundColor,
                    child: CustomText(
                      text: '$myindex',
                      color: light,
                      size: 16,
                    ),
                  ),
              ],
            ),
            const Divider(
              height: space_20,
            ),
            Container(
              height: 200,
              padding: const EdgeInsets.all(space_10),
              child: SafeArea(
                child: ListView.builder(
                    itemCount: myindex,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CaseTaskWidget(
                          caseName: "Set Hearing Date",
                          task:
                              '${index + 1} Discuss with the prosectur to schedule and finalize a hearing date.');
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ongoingcases(double height, String title, int status, String casename,
      QuerySnapshot data) {
    return Expanded(
      child: Container(
        height: height,
        padding: const EdgeInsets.all(paddingMid),
        decoration: BoxDecoration(
            color: legistwhite,
            border: Border.all(color: lightGrey, width: .5),
            borderRadius: BorderRadius.circular(space_20)),
        child: Column(
          children: [
            Text(title,
                style: GoogleFonts.getFont('Poppins',
                    textStyle:
                        const TextStyle(fontSize: fontHeader, color: dark))),
            const Divider(
              height: space_20,
            ),
            Container(
              height: 200,
              padding: const EdgeInsets.all(space_10),
              child: SafeArea(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.appState.myid)
                        .collection('tasks')
                        .doc(data.docs[widget.caseNo]['casenumber'])
                        //.doc(casename)
                        .collection("taskscol")
                        .where("status", isEqualTo: status)
                        .orderBy("priority", descending: false)
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

                      return ListView.builder(
                          itemCount: data.size,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CaseTaskWidget(
                                caseName: data.docs[index]['name'],
                                task: data.docs[index]['description']);
                          });
                    }),
              ),
            ),
            /*Expanded(child: Container()),
            const Divider(
              height: 20,
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () {
                sideMenuController.changeActiveItemTo("Calendar");
                widget.appState.selectedIndex = 10;
              },
              child: Text('View All',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont('Comfortaa',
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: foregroundColor))),
            ),*/
          ],
        ),
      ),
    );
  }
}
