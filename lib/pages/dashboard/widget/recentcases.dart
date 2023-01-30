import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/myconstants.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:intl/intl.dart';
import 'package:urlnav2/pages/dashboard/widget/dashboard_task_card.dart';
import 'package:web_date_picker/web_date_picker.dart';

class RecentCasesWidget extends StatefulWidget {
  final AppState appState;
  RecentCasesWidget({Key key, this.appState}) : super(key: key);

  @override
  State<RecentCasesWidget> createState() => _RecentCasesWidgetState();
}

class _RecentCasesWidgetState extends State<RecentCasesWidget> {
  ScrollController _controller;
  CollectionReference addmilestone;
  var startingdate = "";
  var endingdate = "";
  final milestonetitlecontroller = TextEditingController();
  final milestonestatuscontroller = TextEditingController();

  @override
  void initState() {
    _controller = ScrollController();

    addmilestone = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('cases');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 300,
        padding: const EdgeInsets.all(paddingMid),
        decoration: BoxDecoration(
            color: legistwhite,
            border: Border.all(color: lightGrey, width: .5),
            borderRadius: BorderRadius.circular(space_20)),
        child: Column(
          children: [
            Text('Recent Cases',
                style: GoogleFonts.getFont('Poppins',
                    textStyle:
                        const TextStyle(fontSize: fontHeader, color: dark))),
            const Divider(
              height: space_20,
            ),
            scrollmilestone(),
            Expanded(child: Container()),
            const Divider(
              height: space_20,
            ),
            y10,
            InkWell(
              onTap: () {
                sideMenuController.changeActiveItemTo("Cases");
                widget.appState.selectedIndex = 3;
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

  Widget myrecentcaselist(String casename) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text('New',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont('Poppins',
                      textStyle: const TextStyle(fontSize: 16, color: dark))),
              y10,
              DashboardTaskCard(
                caseName: casename,
                task: DateTime.now().toString(),
              ),
            ],
          ),
        ),
        const VerticalDivider(),
      ],
    );
  }

  Color mycolor(int index) {
    int newindex = 0;

    if (index % 2 == 0) {
      newindex = 2;
    } else if (index % 3 == 0) {
      newindex = 3;
    } else if (index % 4 == 0) {
      newindex = 4;
    } else {
      newindex = 1;
    }

    switch (newindex) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.green;
      case 4:
        return Colors.red;
      default:
        return Colors.amber;
    }
  }

  Widget scrollmilestone2() {
    return Container(
      height: 100,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
                stream: addmilestone.snapshots(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.data.docs.isEmpty) {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () {
                          sideMenuController.changeActiveItemTo("Cases");
                          widget.appState.selectedIndex = 7;
                        },
                        child: const CustomText(
                          text: "Please Add Cases",
                          color: legistwhite,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      itemCount: snapshot.data.size,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              DashboardTaskCard(
                                caseName: snapshot.data.docs[index]["casename"],
                                task: DateTime.now().toString(),
                              ),
                            ],
                          ),
                        );
                      });
                }),
          ),
          Flexible(
            child: Row(
              children: [
                InkWell(
                    onHover: (value) {},
                    onTap: () {
                      _moveUp(150);
                    },
                    child: Icon(Icons.chevron_left_sharp)),
                Expanded(child: Container()),
                InkWell(
                    onTap: () {
                      _moveDown(150);
                    },
                    child: Icon(Icons.chevron_right_sharp)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _moveUp(double itemSize) {
    _controller.animateTo(_controller.offset - itemSize,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  _moveDown(double itemSize) {
    _controller.animateTo(_controller.offset + itemSize,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  Widget scrollmilestone() {
    return Container(
      height: 100,
      child: Row(
        children: [
          InkWell(
              onHover: (value) {},
              onTap: () {
                _moveUp(150);
              },
              child: Icon(Icons.chevron_left_sharp)),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: addmilestone.snapshots(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.data.docs.isEmpty) {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () {
                          sideMenuController.changeActiveItemTo("Cases");
                          widget.appState.selectedIndex = 7;
                        },
                        child: const CustomText(
                          text: "Please Add Cases",
                          color: legistwhite,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      itemCount: snapshot.data.size,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              DashboardTaskCard(
                                caseName: snapshot.data.docs[index]["casename"],
                                task: DateTime.now().toString(),
                              ),
                            ],
                          ),
                        );
                      });
                }),
          ),
          InkWell(
              onTap: () {
                _moveDown(150);
              },
              child: Icon(Icons.chevron_right_sharp)),
        ],
      ),
    );
  }
}
