import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';

class ActivityProfile extends StatefulWidget {
  final AppState appState;
  const ActivityProfile({Key key, this.appState}) : super(key: key);

  @override
  State<ActivityProfile> createState() => _ActivityProfileState();
}

class _ActivityProfileState extends State<ActivityProfile> {
  final textcontroller = TextEditingController();
  final textcontroller2 = TextEditingController();
  final textcontroller3 = TextEditingController();

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
              CustomText(
                text: "Activities",
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
                              mydialogbutton(),
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
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return myschool(
                      snapshot.data.docs[index]['myschool'],
                      snapshot.data.docs[index]['mystudy'],
                      snapshot.data.docs[index]['mystudyyear']);
                }));
      },
    );
  }

  Widget mydialogbutton() {
    return TextButton(
      child: Text('Okay'),
      onPressed: () {
        addabout
            .add({
              'att1': textcontroller.text,
              'att2': textcontroller.text,
              'att3': textcontroller.text,
            })
            .then((value) => print('Skills added successfully'))
            .catchError((error) => print('Failed to create new skill: $error'));
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

  Widget mydialogcontent() {
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
        SizedBox(
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
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: textcontroller3,
          validator: (value) {
            return value.isNotEmpty ? null : "Invalid Field";
          },
          decoration: InputDecoration(
              labelText: "Enter Date",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ));
  }
}
