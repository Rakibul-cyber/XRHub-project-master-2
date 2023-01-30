import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:intl/intl.dart';
import 'package:web_date_picker/web_date_picker.dart';

class SchoolProfile extends StatefulWidget {
  final AppState appState;
  const SchoolProfile({Key key, this.appState}) : super(key: key);

  @override
  State<SchoolProfile> createState() => _SchoolProfileState();
}

class _SchoolProfileState extends State<SchoolProfile> {
  final textcontroller = TextEditingController();
  final textcontroller2 = TextEditingController();
  var startingdate = "";
  var endingdate = "";

  Stream<QuerySnapshot> about;
  CollectionReference addabout;

  @override
  void initState() {
    about = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('schools')
        .snapshots();

    addabout = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('schools');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          color: legistwhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: lightGrey, width: .5),
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: "Education",
                weight: FontWeight.w900,
                size: 15,
              ),
              InkWell(
                child: Icon(Icons.add),
                onTap: () {
                  opendialog(context);
                },
              )
            ],
          ),
          mylist()
        ]));
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

  Widget mylist() {
    return StreamBuilder<QuerySnapshot>(
      stream: about,
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
          return const CustomText(text: "Add Education", color: grey);
        }
        return Container(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return myschool(
                      snapshot.data.docs[index]['myschool'],
                      snapshot.data.docs[index]['mystudy'],
                      "${snapshot.data.docs[index]['startdt']} - ${snapshot.data.docs[index]['enddt']}");
                }));
      },
    );
  }

  Widget mydialogbutton(BuildContext context) {
    return TextButton(
      child: Text('Okay'),
      onPressed: () {
        addabout
            .add({
              'myschool': textcontroller.text,
              'mystudy': textcontroller2.text,
              'startdt': startingdate,
              'enddt': endingdate,
            })
            .then((value) => print('Skills added successfully'))
            .catchError((error) => print('Failed to create new skill: $error'));
        textcontroller.text = "";
        textcontroller2.text = "";

        Navigator.pop(context);
      },
    );
  }

  Widget myschool(String name, String subject, String year) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Icon(
              Icons.school,
              size: 50,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name,
                  weight: FontWeight.bold,
                  size: 13,
                ),
                CustomText(
                  text: subject,
                  weight: FontWeight.w500,
                  size: 12,
                ),
                CustomText(
                  text: year,
                  weight: FontWeight.normal,
                  color: dark.withOpacity(0.5),
                  size: 12,
                )
              ],
            ),
          ),
        ],
      ),
    );
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
          controller: textcontroller,
          validator: (value) {
            return value.isNotEmpty ? null : "Invalid Field";
          },
          decoration: InputDecoration(
              labelText: "School",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: textcontroller2,
          validator: (value) {
            return value.isNotEmpty ? null : "Invalid Field";
          },
          decoration: InputDecoration(
              labelText: "Enter Field of Study",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            WebDatePicker(
              onChange: (value) {
                startingdate =
                    DateFormat('EEE, d/M/y').format(value).toString();
              },
            ),
            WebDatePicker(
              onChange: (value) {
                endingdate = DateFormat('EEE, d/M/y').format(value).toString();
              },
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
                          lastDate: DateTime(2025),
                        ).then((value) {
                          setState(() {
                            startingdate = DateFormat('EEE, d/M/y')
                                .format(value)
                                .toString();
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
                        Navigator.of(context).pop();

                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2025))
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
}
