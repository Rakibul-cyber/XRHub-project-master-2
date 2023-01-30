import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:intl/intl.dart';
import 'package:web_date_picker/web_date_picker.dart';

class ExperienceProfile extends StatefulWidget {
  final AppState appState;
  const ExperienceProfile({Key key, this.appState}) : super(key: key);

  @override
  State<ExperienceProfile> createState() => _ExperienceProfileState();
}

class _ExperienceProfileState extends State<ExperienceProfile> {
  final textcontroller = TextEditingController();
  final textcontroller2 = TextEditingController();
  var startingdate = "";

  Stream<QuerySnapshot> about;
  CollectionReference addabout;

  @override
  void initState() {
    about = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('eperience')
        .snapshots();

    addabout = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('eperience');
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
              CustomText(
                text: "Experience",
                weight: FontWeight.w900,
                size: 15,
              ),
              InkWell(
                child: Icon(Icons.add),
                onTap: () async {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return AlertDialog(
                            actionsAlignment: MainAxisAlignment.center,
                            content: mydialogcontent(),
                            actions: <Widget>[
                              mydialogbutton(context),
                            ],
                          );
                        });
                      });
                },
              )
            ],
          ),
          mylist()
        ]));
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
        return Container(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
                reverse: true,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return mycompany(
                      snapshot.data.docs[index]['jobtitle'],
                      "${snapshot.data.docs[index]['firmname']}",
                      "${snapshot.data.docs[index]['jobstartingdt']}- Present");
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
              'firmname': textcontroller.text,
              'jobtitle': textcontroller2.text,
              'jobstartingdt': startingdate ?? "",
            })
            .then((value) => print('Skills added successfully'))
            .catchError((error) => print('Failed to create new skill: $error'));
        textcontroller.text = "";
        textcontroller2.text = "";
        startingdate = "";

        Navigator.pop(context);
      },
    );
  }

  Widget mycompany(String name, String subject, String year) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Column(
              children: [
                Icon(
                  Icons.work,
                  size: 50,
                ),
              ],
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

  Widget mydialogcontent() {
    return Form(
        //key: _formKey,
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Add Experience",
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
              labelText: "Firm Name",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: textcontroller2,
          validator: (value) {
            return value.isNotEmpty ? null : "Invalid Field";
          },
          decoration: InputDecoration(
              labelText: "Job Title",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        SizedBox(
          height: 10,
        ),
        WebDatePicker(
          onChange: (value) {
            startingdate = DateFormat('EEE, d/M/y').format(value).toString();
          },
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ));
  }
}
