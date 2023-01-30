import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/myconstants.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/pages/cases/selectedCaseState.dart';
import 'package:urlnav2/pages/tasks/selectedtaskstate.dart';

class Casecard2 extends StatelessWidget {
  final String caseNumber;
  final String caseName;
  final String status;
  final String clientName;
  final String caseDesp;
  final String users;
  final int index;
  final AppState appState;
  final SelectedTaskState selectedTaskState;
  final SelectedCaseState selectedCaseState;

  const Casecard2(
      Key key,
      this.caseNumber,
      this.caseName,
      this.status,
      this.clientName,
      this.caseDesp,
      this.users,
      this.index,
      this.appState,
      this.selectedTaskState,
      this.selectedCaseState)
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        sideMenuController.changeActiveItemTo("Cases");
        selectedCaseState.selectedCase = index;
        /*Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CaseDashboardScreen(
                      myindex: index,
                    )));*/
      },
      child: Container(
        padding: const EdgeInsets.all(30.0),
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
        child: ListView(children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CustomText(
                        text: caseName,
                        color: legistblue,
                        size: 18,
                        weight: FontWeight.bold,
                        talign: TextAlign.center),
                    const SizedBox(height: 5),
                    Text(caseNumber,
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            //fontStyle: FontStyle.italic,
                            color: Colors.grey[500])),
                  ],
                ),
              ),
            ],
          ),
          if (ResponsiveWidget.isLargeScreen(context))
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: LinearProgressIndicator(
                    semanticsValue: "45%",
                    value: 0.45,
                  )),
                ],
              ),
            ),
          if (ResponsiveWidget.isLargeScreen(context))
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  clientcontainer(),
                  x10,
                  taskcontainer(),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: bigscreenDetails(),
          ),
        ]),
      ),
    );
  }

  Widget clientcontainer() {
    return Expanded(
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: silver,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            const CircleAvatar(
              backgroundColor: dark,
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundColor: light,
                  child: Icon(
                    Icons.person_outline,
                    color: dark,
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
            Text("$clientName",
                style: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }

  Widget taskcontainer() {
    return Expanded(
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: silver,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          height: 80,
          child: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(appState.myid)
                    .collection('tasks')
                    .doc(caseNumber)
                    .collection('taskscol')
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
                        return Column(
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(),
                                onPressed: () {
                                  sideMenuController
                                      .changeActiveItemTo("Tasks");
                                  appState.selectedIndex = 11;
                                  selectedTaskState.selectedTask = caseNumber;
                                },
                                child: CustomText(
                                  talign: TextAlign.center,
                                  color: legistwhite,
                                  text: data.docs[index]['name'],
                                )),
                            y10
                          ],
                        );
                      });
                }),
          ),
        ),
      ),
    );
  }

  Widget bigscreenDetails() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Status: ",
                style: GoogleFonts.openSans(
                    fontSize: 15, color: Colors.black.withOpacity(.5))),
            Text(status,
                style: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.bold))
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Description: ",
                style: GoogleFonts.openSans(
                    fontSize: 15, color: Colors.black.withOpacity(.5))),
            Text(overflowtext(caseDesp),
                style: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.bold))
          ],
        ),
      ],
    );
  }

  String overflowtext(String mystring) {
    int truncateAt = 7;
    String elepsis = "...";

    if (mystring.length > truncateAt) {
      return mystring.substring(0, truncateAt - elepsis.length) + elepsis;
    } else {
      return mystring;
    }
  }

  Future<List> getRelatedTasks() async {
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('tasks').get();

    List<String> docInfo = [/* 'docId', 'taskName' */];

    for (var document in snap.docs) {
      if (caseName == document['case']) {
        docInfo.add(document.id);
        docInfo.add(document['name']);
        if (kDebugMode) {
          print('${docInfo[0]} | ${docInfo[1]}');
        }
        return docInfo;
      }
    }
  }

  Widget buildRelatedTasks() {
    return FutureBuilder(
      future: getRelatedTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ElevatedButton(
            onPressed: () {
              //TODO: Direct to the task page.
              //   Navigator.of(context).push(
              //       MaterialPageRoute(builder: ((context) => ViewTaskPage())));
            },
            child: Text(snapshot.data[1]),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
