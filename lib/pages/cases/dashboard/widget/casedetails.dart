import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';

class CaseDetails extends StatefulWidget {
  final AppState appstate;
  final int caseNo;
  CaseDetails({Key key, this.caseNo, this.appstate}) : super(key: key);

  @override
  State<CaseDetails> createState() => _CaseDetailsState();
}

class _CaseDetailsState extends State<CaseDetails> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.appstate.myid)
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
    return Flexible(
      flex: 1,
      child: Container(
          padding: const EdgeInsets.all(paddingMid),
          decoration: BoxDecoration(
              color: legistwhite,
              border: Border.all(color: lightGrey, width: .5),
              borderRadius: BorderRadius.circular(space_20)),
          child: Column(
            children: [
              Container(
                height: 1000,
                padding: const EdgeInsets.all(paddingMin),
                child: ListView(
                  children: [
                    const CustomText(
                      text: 'Case Details',
                      color: dark,
                      size: fontHeader,
                    ),
                    const Divider(height: space_30),
                    clientnamecell(
                        "Case Name", data.docs[widget.caseNo]['casename']),
                    clientnamecell(
                        "Client Name", data.docs[widget.caseNo]['clientname']),
                    clientnamecell("Stage of\ncase",
                        data.docs[widget.caseNo]['stageofcase']),
                    clientnamecell("Case Description",
                        data.docs[widget.caseNo]['casedescription']),
                    clientnamecell(
                        "Case Number", data.docs[widget.caseNo]['casenumber']),
                    clientnamecell(
                        "Case Type", data.docs[widget.caseNo]['casetypes']),
                    clientnamecell("Case Subtype",
                        data.docs[widget.caseNo]['casesubtypes']),
                    clientnamecell("Acts", data.docs[widget.caseNo]['acts']),
                    clientnamecell(
                        "CNR Number", data.docs[widget.caseNo]['cnrnumber']),
                    clientnamecell("Court", data.docs[widget.caseNo]['court']),
                    clientnamecell(
                        "Court Type", data.docs[widget.caseNo]['courttype']),
                    clientnamecell(
                        "Filing Date", data.docs[widget.caseNo]['filingdate']),
                    clientnamecell("Filing Number",
                        data.docs[widget.caseNo]['filinnumber']),
                    clientnamecell("First Hearing\nDate",
                        data.docs[widget.caseNo]['firsthearingdt']),
                    clientnamecell(
                        "Judge Name", data.docs[widget.caseNo]['jdgname']),
                    clientnamecell(
                        "Judge Type", data.docs[widget.caseNo]['jdgtype']),
                    clientnamecell("Registration\nDate",
                        data.docs[widget.caseNo]['regdate']),
                    clientnamecell("Registration\nNumber",
                        data.docs[widget.caseNo]['regnum']),
                    clientnamecell(
                        "Remarks", data.docs[widget.caseNo]['remarks']),
                    clientnamecell("Respondant\nAdvocate",
                        data.docs[widget.caseNo]['respondantadv']),
                    clientnamecell("Respondant\nName",
                        data.docs[widget.caseNo]['respondantname']),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget clientnamecell(String title, String name) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              talign: TextAlign.start,
              text: title,
              color: dark,
              size: 13,
              weight: FontWeight.bold,
            ),
            CustomText(
              talign: TextAlign.end,
              text: name,
              color: dark,
              size: 13,
            ),
          ],
        ),
        y20,
      ],
    );
  }
}
