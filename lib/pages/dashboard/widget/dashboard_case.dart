import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/myconstants.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:flutter/material.dart';

class DashboardCaseWidget extends StatefulWidget {
  final String userid;
  final AppState appState;

  const DashboardCaseWidget({ this.userid,  this.appState})
      ;

  @override
  State<DashboardCaseWidget> createState() => _DashboardCaseWidget();
}

class _DashboardCaseWidget extends State<DashboardCaseWidget> {
  int myclientindex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      padding: const EdgeInsets.all(space_10),
      child: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
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
                return const Center(child: CircularProgressIndicator());
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
                        color: legistwhitefont,
                      )),
                );
              }
              final data = snapshot.requireData;

              return buildCase(data);
            }),
      ),
    );
  }

  Widget buildCase2(String casename) {
    return CustomText(
      text: casename,
    );
  }

  Widget buildCase(QuerySnapshot<Object> data) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              if (myclientindex > 0) {
                myclientindex -= 1;
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.all(paddingSmall),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                border: Border.all(color: foregroundColor, width: 1)),
            child: const Icon(
              Icons.arrow_back,
              color: foregroundColor,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(paddingMid),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(paddingSmall),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(space_30),
                              color: const Color.fromARGB(135, 137, 180, 255)),
                          child: const Icon(Icons.folder_copy_outlined,
                              size: 72, color: foregroundColor)),
                      CustomText(
                        text: data.docs[myclientindex]['casename'],
                        color: foregroundColor,
                        size: fontHeader,
                      ),
                    ]),
                y20,
                const Divider(height: space_30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Progress',
                        color: foregroundColor,
                        size: 16,
                      ),
                      y10,
                      LinearProgressIndicator(
                        value: 0.76,
                        color: foregroundColor,
                      ),
                      y30,
                      const CustomText(
                        text: 'Case Details',
                        color: foregroundColor,
                        size: 16,
                      ),
                      const Divider(height: space_30),
                      casedetails(data, myclientindex),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              if (myclientindex < (data.size - 1)) myclientindex += 1;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(paddingSmall),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                border: Border.all(color: foregroundColor, width: 1)),
            child: const Icon(
              Icons.arrow_forward,
              color: foregroundColor,
            ),
          ),
        )
      ],
    );
  }

  Widget members() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Members',
          color: foregroundColor,
          size: 16,
        ),
        y20,
        Row(
          children: [
            CircleAvatar(
                backgroundColor: Colors.red,
                child: CustomText(
                  text: 'HM',
                  color: light,
                  size: 16,
                )),
            x10,
            CircleAvatar(
                backgroundColor: Colors.brown,
                child: CustomText(
                  text: 'CY',
                  color: light,
                  size: 16,
                )),
            x10,
            CircleAvatar(
                backgroundColor: Colors.amber,
                child: CustomText(
                  text: 'JC',
                  color: light,
                  size: 16,
                )),
            x10,
            CircleAvatar(
                backgroundColor: Color.fromARGB(255, 108, 10, 201),
                child: CustomText(
                  text: 'LK',
                  color: light,
                  size: 16,
                )),
            x10,
            InkWell(
              onTap: () {},
              child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(space_20),
                      color: const Color.fromARGB(135, 137, 180, 255)),
                  child: CustomText(
                    text: 'View all 16 members',
                    color: foregroundColor,
                    size: 14,
                  )),
            ),
          ],
        )
      ],
    );
  }

  Widget casedetails(QuerySnapshot<Object> data, int casenumber) {
    return Container(
      height: 600,
      padding: const EdgeInsets.all(paddingMin),
      child: ListView(
        children: [
          clientnamecell("Case Name", data.docs[casenumber]['casename']),
          clientnamecell("Client Name", data.docs[casenumber]['clientname']),
          clientnamecell(
              "Stage of\ncase", data.docs[casenumber]['stageofcase']),
          clientnamecell(
              "Case Description", data.docs[casenumber]['casedescription']),
          clientnamecell("Case Number", data.docs[casenumber]['casenumber']),
          clientnamecell("Case Type", data.docs[casenumber]['casetypes']),
          clientnamecell("Case Subtype", data.docs[casenumber]['casesubtypes']),
          clientnamecell("Acts", data.docs[casenumber]['acts']),
          clientnamecell("CNR Number", data.docs[casenumber]['cnrnumber']),
          clientnamecell("Court", data.docs[casenumber]['court']),
          clientnamecell("Court Type", data.docs[casenumber]['courttype']),
          clientnamecell("Filing Date", data.docs[casenumber]['filingdate']),
          clientnamecell("Filing Number", data.docs[casenumber]['filinnumber']),
          clientnamecell(
              "First Hearing\nDate", data.docs[casenumber]['firsthearingdt']),
          clientnamecell("Judge Name", data.docs[casenumber]['jdgname']),
          clientnamecell("Judge Type", data.docs[casenumber]['jdgtype']),
          clientnamecell(
              "Registration\nDate", data.docs[casenumber]['regdate']),
          clientnamecell(
              "Registration\nNumber", data.docs[casenumber]['regnum']),
          clientnamecell("Remarks", data.docs[casenumber]['remarks']),
          clientnamecell(
              "Respondant\nAdvocate", data.docs[casenumber]['respondantadv']),
          clientnamecell(
              "Respondant\nName", data.docs[casenumber]['respondantname']),
        ],
      ),
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
