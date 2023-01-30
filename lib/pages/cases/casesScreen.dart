import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/myconstants.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/pages/cases/selectedCaseState.dart';
import 'package:urlnav2/pages/cases/widgets/cases_card2.dart';
import 'package:urlnav2/pages/tasks/selectedtaskstate.dart';

class CasesScreen extends StatefulWidget {
  final SelectedCaseState selectedCaseState;
  final SelectedTaskState selectedTaskState;
  final AppState appState;
  const CasesScreen(
      {Key key, this.selectedCaseState, this.selectedTaskState, this.appState})
      : super(key: key);

  @override
  _CasesScreen createState() => _CasesScreen();
}

class _CasesScreen extends State<CasesScreen> {
  Stream<QuerySnapshot> cases;

  @override
  void initState() {
    cases = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('cases')
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
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.data.docs.isEmpty) {
              return Center(
                child: ElevatedButton(
                    onPressed: () {
                      sideMenuController.changeActiveItemTo("Add New Client");
                      widget.appState.selectedIndex = 7;
                    },
                    child: const CustomText(
                      text: "Add Case",
                      color: legistwhite,
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
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Colors.blue,
          onPressed: () {
            sideMenuController.changeActiveItemTo("Add New Client");
            widget.appState.selectedIndex = 7;
          }),
    );
  }

  Widget caseslist(BuildContext context, QuerySnapshot<Object> data) {
    return Expanded(
        child: GridView.builder(
      itemCount: data.size,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisSpacing: 20,
        crossAxisCount: ResponsiveWidget.isLargeScreen(context)
            ? 4
            : ResponsiveWidget.isMediumScreen(context)
                ? 3
                : 2,
      ),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Casecard2(
            widget.key,
            data.docs[index]['casenumber'],
            data.docs[index]['casename'],
            data.docs[index]['stageofcase'],
            data.docs[index]['clientname'],
            data.docs[index]['casedesp'],
            data.docs[index]['usrassign'],
            index,
            widget.appState,
            widget.selectedTaskState,
            widget.selectedCaseState),
      ),
    ));
  }
}
