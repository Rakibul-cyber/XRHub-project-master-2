import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/pages/cases/dashboard/widget/case_note.dart';
import 'package:urlnav2/pages/files/components/custom_icons.dart';
import 'package:intl/intl.dart';

class CaseNoteWidget extends StatefulWidget {
  final AppState appState;
  final int caseNo;
  CaseNoteWidget({Key key, this.appState, this.caseNo}) : super(key: key);

  @override
  State<CaseNoteWidget> createState() => _CaseNoteWidgetState();
}

class _CaseNoteWidgetState extends State<CaseNoteWidget> {
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

          return caseslist(data);
        });
  }

  Widget caseslist(QuerySnapshot mydata) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.appState.myid)
            .collection('notes')
            .where("case", isEqualTo: mydata.docs[widget.caseNo]["casename"])
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

          if (snapshot.data.docs.isEmpty) {
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(paddingMid),
                decoration: BoxDecoration(
                    color: legistwhite,
                    border: Border.all(color: lightGrey, width: .5),
                    borderRadius: BorderRadius.circular(space_20)),
                height: 335,
                child: Column(
                  children: [
                    Text('Notes',
                        style: GoogleFonts.getFont('Poppins',
                            textStyle: const TextStyle(
                                fontSize: fontHeader, color: dark))),
                    const Divider(
                      height: space_20,
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                            child: ElevatedButton(
                          onPressed: () {},
                          child: const CustomText(
                            talign: TextAlign.center,
                            color: lightGrey,
                            text: "Create Notes",
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          final data = snapshot.requireData;

          return Flexible(
            child: Container(
              padding: const EdgeInsets.all(paddingMid),
              decoration: BoxDecoration(
                  color: legistwhite,
                  border: Border.all(color: lightGrey, width: .5),
                  borderRadius: BorderRadius.circular(space_20)),
              height: 335,
              child: Column(
                children: [
                  Text('Notes',
                      style: GoogleFonts.getFont('Poppins',
                          textStyle: const TextStyle(
                              fontSize: fontHeader, color: dark))),
                  const Divider(
                    height: space_20,
                  ),
                  Container(
                    child: ListView.builder(
                        itemCount: data.size,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return DashboardMemoWidget(
                              caseName: data.docs[index]["title"],
                              memo: data.docs[index]["mynotes"]);
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
