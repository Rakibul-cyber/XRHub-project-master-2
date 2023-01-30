import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:urlnav2/appState.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';

class AboutProfile extends StatefulWidget {
  final AppState appState;
  const AboutProfile({Key key, this.appState}) : super(key: key);

  @override
  State<AboutProfile> createState() => _AboutProfileState();
}

class _AboutProfileState extends State<AboutProfile> {
  final textcontroller = TextEditingController();

  Stream<QuerySnapshot> about;
  CollectionReference addabout;

  @override
  void initState() {
    about = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('about')
        .snapshots();

    addabout = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.appState.myid)
        .collection('about');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
        color: legistwhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: about,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }
          if (snapshot.data.docs.isEmpty) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Container()),
                    InkWell(
                      child: Icon(Icons.add),
                      onTap: () async {
                        mydialogempty();
                      },
                    )
                  ],
                ),
                const CustomText(
                    text: "Please tell us about yourself", color: grey),
              ],
            );
          }
          return maincontainer(snapshot.data, context);
        },
      ),
    );
  }

  Widget maincontainer(QuerySnapshot data, BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomText(
            text: "About",
            weight: FontWeight.w900,
            size: 15,
          ),
          InkWell(
            child: data.size == 0 ? Icon(Icons.add) : Icon(Icons.edit),
            onTap: () async {
              textcontroller.text = data.docs[0]["myabout"];
              mydialog(data);
            },
          )
        ],
      ),
      mylist(data)
    ]);
  }

  void mydialog(QuerySnapshot data) async {
    await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              content: mydialogcontent(),
              actions: <Widget>[
                mydialogbutton(data, context),
              ],
            );
          });
        });
  }

  void mydialogempty() async {
    await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              content: mydialogcontent(),
              actions: <Widget>[
                mydialogbuttonempty(context),
              ],
            );
          });
        });
  }

  Widget mylist(QuerySnapshot data) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: CustomText(
        text: data.docs[0]["myabout"],
        size: 12,
        weight: FontWeight.w200,
      ),
    );
  }

  Widget mydialogbutton(QuerySnapshot data, BuildContext context) {
    return TextButton(
      child: Text('Okay'),
      onPressed: () {
        addabout
            .doc(data.docs.first.id)
            .set({
              'myabout': textcontroller.text,
            })
            .then((value) => print('Skills added successfully'))
            .catchError((error) => print('Failed to create new skill: $error'));
        Navigator.of(context).pop();
      },
    );
  }

  Widget mydialogbuttonempty(BuildContext context) {
    return TextButton(
      child: Text('Okay'),
      onPressed: () {
        addabout
            .add({
              'myabout': textcontroller.text,
            })
            .then((value) => print('Skills added successfully'))
            .catchError((error) => print('Failed to create new skill: $error'));
        Navigator.of(context).pop();
      },
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
          text: "About",
          weight: FontWeight.bold,
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          maxLines: 5,
          controller: textcontroller,
          validator: (value) {
            return value.isNotEmpty ? null : "Invalid Field";
          },
          decoration: InputDecoration(
              labelText: "Tell us about yourself",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    ));
  }
}
