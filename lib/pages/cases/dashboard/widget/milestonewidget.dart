import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:intl/intl.dart';
import 'package:web_date_picker/web_date_picker.dart';

class MileStoneWidget extends StatefulWidget {
  final int caseNo;
  final AppState appState;
  MileStoneWidget({Key key, this.caseNo, this.appState}) : super(key: key);

  @override
  State<MileStoneWidget> createState() => _MileStoneWidgetState();
}

class _MileStoneWidgetState extends State<MileStoneWidget> {
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
        .collection('milestones');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(paddingMid),
      decoration: BoxDecoration(
          color: legistwhite,
          border: Border.all(color: lightGrey, width: .5),
          borderRadius: BorderRadius.circular(space_20)),
      child: Column(
        children: [
          Text('Milestones',
              style: GoogleFonts.getFont('Poppins',
                  textStyle:
                      const TextStyle(fontSize: fontHeader, color: dark))),
          const Divider(
            height: space_20,
          ),
          Expanded(child: scrollmilestone()),
          Row(
            children: [
              Expanded(child: Container()),
              IconButton(
                  onPressed: () {
                    opendialog(context);
                  },
                  icon: const Icon(Icons.add))
            ],
          )
        ],
      ),
    );
  }

  Widget milestoneCell(
      int index, String title, String duedate, String status, int size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: legistwhite,
                  border: Border.all(
                      color:
                          index.floor().isEven ? lightGrey : Colors.transparent,
                      width: .5),
                  borderRadius: BorderRadius.circular(space_20)),
              child: Column(
                children: [
                  CustomText(
                    text: duedate,
                    color: index.floor().isEven ? grey : Colors.transparent,
                  ),
                  CustomText(
                    text: status,
                    color: index.floor().isEven ? grey : Colors.transparent,
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: 40,
              color: index.floor().isEven ? lightGrey : Colors.transparent,
            ),
            Container(
              alignment: Alignment.center,
              height: 120,
              width: 120,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: mycolor(index),
                  border: Border.all(color: lightGrey, width: .5),
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: CustomText(
                  text: title,
                  talign: TextAlign.center,
                  color: legistwhite,
                ),
              ),
            ),
            Container(
              width: 1,
              height: 40,
              color: !index.floor().isEven ? lightGrey : Colors.transparent,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: legistwhite,
                  border: Border.all(
                      color: !index.floor().isEven
                          ? lightGrey
                          : Colors.transparent,
                      width: .5),
                  borderRadius: BorderRadius.circular(space_20)),
              child: Column(
                children: [
                  CustomText(
                    text: duedate,
                    color: !index.floor().isEven ? grey : Colors.transparent,
                  ),
                  CustomText(
                    text: status,
                    color: !index.floor().isEven ? grey : Colors.transparent,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (size != (index + 1))
          Container(
            width: 40,
            height: 1,
            color: lightGrey,
          ),
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

  Widget scrollmilestone() {
    return Container(
      height: 100,
      child: Stack(
        //alignment: AlignmentDirectional.center,
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: addmilestone
                  .where("casenumber", isEqualTo: widget.caseNo)
                  .snapshots(),
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
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    itemCount: snapshot.data.size,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return milestoneCell(
                        index,
                        snapshot.data.docs[index]["title"],
                        snapshot.data.docs[index]["enddt"],
                        snapshot.data.docs[index]["status"],
                        snapshot.data.size,
                      );
                    });
              }),
          Row(
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

  void opendialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              content: mydialogcontent(context),
              actions: <Widget>[
                mydialogbutton(context),
              ],
            );
          });
        });
  }

  Widget mydialogcontent(BuildContext context) {
    return Form(
        //key: _formKey,
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Add Post",
          weight: FontWeight.bold,
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: milestonetitlecontroller,
          validator: (value) {
            return value.isNotEmpty ? null : "Invalid Field";
          },
          decoration: InputDecoration(
              labelText: "Title",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: milestonestatuscontroller,
          validator: (value) {
            return value.isNotEmpty ? null : "Invalid Field";
          },
          decoration: InputDecoration(
              labelText: "Status",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: WebDatePicker(
                onChange: (value) {
                  startingdate =
                      DateFormat('EEE, d/M/y').format(value).toString();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: WebDatePicker(
                onChange: (value) {
                  endingdate =
                      DateFormat('EEE, d/M/y').format(value).toString();
                },
              ),
            ),
            /*Flexible(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();

                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2023),
                        ).then((value) {
                          setState(() {
                            startingdate = DateFormat('EEE, d/M/y')
                                .format(value)
                                .toString();
                            //opendialog(context);
                          });
                        });
                        //Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border:
                              Border.all(color: dark.withOpacity(.5), width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: CustomText(
                                    color: dark.withOpacity(.8),
                                    text: startingdate == ""
                                        ? "Starting Date"
                                        : startingdate),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))),
            Flexible(
                flex: 1,
                child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2023))
                            .then((value) {
                          setState(() {
                            endingdate = DateFormat('EEE, d/M/y')
                                .format(value)
                                .toString();
                          });
                        });
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border:
                              Border.all(color: dark.withOpacity(.5), width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: CustomText(
                                    color: dark.withOpacity(.8),
                                    text: endingdate == ""
                                        ? "Ending Date"
                                        : endingdate),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))),*/
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ));
  }

  Widget mydialogbutton(BuildContext context) {
    return TextButton(
      child: Text('Okay'),
      onPressed: () {
        addmilestone
            .add({
              'title': milestonetitlecontroller.text,
              'status': milestonestatuscontroller.text,
              'startdt': startingdate,
              'enddt': endingdate,
              'casenumber': widget.caseNo,
            })
            .then((value) => print('Skills added successfully'))
            .catchError((error) => print('Failed to create new skill: $error'));
        milestonetitlecontroller.text = "";
        milestonestatuscontroller.text = "";

        Navigator.pop(context);
      },
    );
  }
}
