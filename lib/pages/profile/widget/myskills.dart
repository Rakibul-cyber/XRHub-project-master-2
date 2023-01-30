import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';

class SkillsProfile extends StatefulWidget {
  final AppState appState;
  SkillsProfile({Key key, this.appState}) : super(key: key);

  @override
  State<SkillsProfile> createState() => _SkillsProfileState();
}

class _SkillsProfileState extends State<SkillsProfile> {
  Stream<QuerySnapshot> skills;
  CollectionReference addskills;
  final _skillsController = TextEditingController();
  final _skillsController2 = TextEditingController();

  @override
  void initState() {
    skills = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('skills')
        .snapshots();

    addskills = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('skills');
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
                text: "Skills",
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
                            content: dialogcontent(),
                            actions: <Widget>[
                              mypresswidget(context),
                            ],
                          );
                        });
                      });
                },
              )
            ],
          ),
          myskills(),
        ]));
  }

  Widget myskills() {
    return StreamBuilder<QuerySnapshot>(
      stream: skills,
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
                  return myskill(snapshot.data.docs[index]['myskills']);
                }));
      },
    );
  }

  Widget dialogcontent() {
    return Form(
        //key: _formKey,
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: "Add Skills",
          weight: FontWeight.bold,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: _skillsController,
          validator: (value) {
            return value.isNotEmpty ? null : "Invalid Field";
          },
          decoration: InputDecoration(
              labelText: "Skills",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: _skillsController2,
          validator: (value) {
            return value.isNotEmpty ? null : "Invalid Field";
          },
          decoration: InputDecoration(
              labelText: "Description",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ));
  }

  Widget mypresswidget(BuildContext context) {
    return ElevatedButton(
      child: const CustomText(
        text: 'Okay',
        color: legistwhitefont,
      ),
      onPressed: () {
        addskills
            .add({
              'myskills': _skillsController.text,
              'about': _skillsController2.text,
            })
            .then((value) => print('Skills added successfully'))
            .catchError((error) => print('Failed to create new skill: $error'));
        _skillsController.text = "";
        _skillsController2.text = "";

        Navigator.pop(context);
      },
    );
  }

  Widget myskill(String refname) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(
            text: refname,
            weight: FontWeight.bold,
            size: 12,
          ),
        ],
      ),
      const SizedBox(height: 10),
      const Divider(
        height: 20,
        thickness: 0.5,
        color: lightGrey,
      ),
    ]);
  }
}
