import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/myconstants.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'package:urlnav2/layout/constants/getcasenumber.dart';
import 'package:urlnav2/layout/constants/getexperience.dart';
import 'package:urlnav2/layout/constants/getmyusername.dart';
import 'package:urlnav2/layout/constants/getprofilepic.dart';
import 'package:urlnav2/pages/cases/dashboard/widget/case_note.dart';
import 'package:urlnav2/pages/cases/dashboard/widget/case_notes.dart';
import 'package:urlnav2/pages/cases/dashboard/widget/case_task.dart';
import 'package:urlnav2/pages/cases/dashboard/widget/casedetails.dart';
import 'package:urlnav2/pages/cases/dashboard/widget/filewidget.dart';
import 'package:urlnav2/pages/cases/dashboard/widget/milestonewidget.dart';
import 'package:urlnav2/pages/cases/dashboard/widget/ongoingcases.dart';
import 'package:urlnav2/pages/cases/selectedCaseState.dart';

class CaseDashboardPage extends StatefulWidget {
  final int caseNo;
  final AppState appState;
  const CaseDashboardPage({Key key, this.caseNo, this.appState})
      : super(key: key);

  @override
  State<CaseDashboardPage> createState() => _CaseDashboardPageState();
}

class _CaseDashboardPageState extends State<CaseDashboardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return method1();
  }

  Widget method1() {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  children: [
                    OnGoingCases(
                      appState: widget.appState,
                      caseNo: widget.caseNo,
                    ),
                    y20,
                    MileStoneWidget(
                      caseNo: widget.caseNo,
                      appState: widget.appState,
                    ),
                    y20,
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          mycalendar(335),
                          x20,
                          CaseNoteWidget(
                            appState: widget.appState,
                            caseNo: widget.caseNo,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              x20,
              if (ResponsiveWidget.isLargeScreen(context))
                CaseDetails(
                  caseNo: widget.caseNo,
                  appstate: widget.appState,
                  //data: widget.data,
                ),
            ],
          ),
        ),
        y20,
        Row(
          children: [
            personincharge(),
            x20,
            FileWidget(
              appState: widget.appState,
              caseNo: widget.caseNo,
            ),
          ],
        )
      ],
    );
  }

  Widget personincharge() {
    return Expanded(
        child: Container(
      height: 300,
      padding: const EdgeInsets.all(paddingMid),
      decoration: BoxDecoration(
          color: legistwhite,
          border: Border.all(color: lightGrey, width: .5),
          borderRadius: BorderRadius.circular(space_20)),
      child: Column(children: [
        const CustomText(
          text: 'Person in Charge',
          color: dark,
          size: fontHeader,
        ),
        const Divider(
          height: space_20,
        ),
        y10,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetProfilePic(
              appState: widget.appState,
            ),
            x10,
            Column(
              children: [
                Getusername(
                  appState: widget.appState,
                ),
              ],
            ),
          ],
        ),
        y20,
        if (ResponsiveWidget.isLargeScreen(context))
          IntrinsicHeight(
            child: Row(children: [
              Expanded(
                child: Column(
                  children: [
                    const CustomText(
                      text: 'Cases',
                      color: dark,
                      size: 14,
                    ),
                    y5,
                    Getcasenumber(
                      appState: widget.appState,
                    ),
                  ],
                ),
              ),
              const VerticalDivider(width: space_10),
              Expanded(
                child: Column(
                  children: [
                    const CustomText(
                      text: 'Experience',
                      color: dark,
                      size: 14,
                    ),
                    y5,
                    GetExperience(
                      appState: widget.appState,
                    )
                  ],
                ),
              ),
              const VerticalDivider(width: space_10),
              Expanded(
                child: Column(
                  children: const [
                    CustomText(
                      text: 'Rating',
                      color: dark,
                      size: 14,
                    ),
                    y5,
                    CustomText(
                      text: '4.5',
                      color: dark,
                      size: 14,
                    ),
                  ],
                ),
              ),
            ]),
          )
      ]),
    ));
  }

  Widget myrecords() {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.all(paddingMid),
      decoration: BoxDecoration(
          color: legistwhite,
          border: Border.all(color: lightGrey, width: .5),
          borderRadius: BorderRadius.circular(space_20)),
      // ignore: prefer_const_literals_to_create_immutables
      child: Column(children: [
        const CustomText(
          text: 'Records',
          color: dark,
          size: fontHeader,
        ),
        const Divider(
          height: space_20,
        ),
        //Note: Gridview not working currently
        Container(
          height: 200,
          child: GridView.builder(
              itemCount: 12,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                crossAxisCount: ResponsiveWidget.isLargeScreen(context)
                    ? 4
                    : ResponsiveWidget.isMediumScreen(context)
                        ? 3
                        : 2,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber),
                  child: Center(
                    child: CustomText(
                      color: legistblackfont,
                      text: "Box ${index + 1}",
                      talign: TextAlign.center,
                    ),
                  ),
                );
              }),
        )
      ]),
    ));
  }

  Widget calendarcell(String whendate, String title, String whattime) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: IntrinsicHeight(
            child: Row(
              children: [
                Text(whendate,
                    style: GoogleFonts.getFont('Comfortaa',
                        textStyle:
                            const TextStyle(fontSize: fontSub, color: dark))),
                const VerticalDivider(
                  width: space_50,
                  color: foregroundColor,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: paddingMin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title,
                            style: GoogleFonts.getFont('Comfortaa',
                                textStyle: const TextStyle(
                                    fontSize: fontSub,
                                    color: foregroundColor))),
                        Text('Noon\n$whattime',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.getFont('Comfortaa',
                                textStyle: const TextStyle(
                                    fontSize: fontSub, color: Colors.grey))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        y10,
      ],
    );
  }

  Widget mynotes(double height) {
    return Expanded(
      child: Container(
        height: height,
        // ignore: prefer_const_constructors
        padding: const EdgeInsets.all(paddingMid),
        decoration: BoxDecoration(
            color: legistwhite,
            border: Border.all(color: lightGrey, width: .5),
            borderRadius: BorderRadius.circular(space_20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Notes',
                textAlign: TextAlign.center,
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
                child: ListView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return DashboardMemoWidget(
                          caseName: 'Gather evidence for case',
                          memo:
                              'Contact Royal Malaysian Police to request and access any material that serve as evidence.');
                    }),
              ),
            ),
            Expanded(child: Container()),
            const Divider(
              height: 20,
            ),
            const SizedBox(height: 5),
            InkWell(
              onTap: () {},
              child: Text('View All',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont('Comfortaa',
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: foregroundColor))),
            ),
          ],
        ),
      ),
    );
  }

  /*buildCaseDetails() {
    return StreamBuilder<QuerySnapshot>(
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
          final data = snapshot.requireData;

          ;
        });
  }*/

  Widget mycalendar(double height) {
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
            Text('Calendar',
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
                        .collection('events')
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
                            return calendarcell(
                                "${data.docs[index]['eventdate']}-${data.docs[index]['eventmonth']}",
                                data.docs[index]['eventtitle'],
                                data.docs[index]['starttime']);
                          });
                    }),
              ),
            ),
            Expanded(child: Container()),
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
            ),
          ],
        ),
      ),
    );
  }
}
