import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:urlnav2/constants/style.dart';

class CreateMileStone extends StatefulWidget {
  CreateMileStone({Key key}) : super(key: key);
  
  @override
  State<CreateMileStone> createState() => _CreateMileStoneState();
}

class _CreateMileStoneState extends State<CreateMileStone> {
  @override
  void initState() {
    //getData();
    super.initState();
  }

  final firebaseFirestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance;
  var targetedDays;
  var date;

  bool check = false;

  Future<dynamic> getData() async {
    FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

    //blood sugar
    var res = await firestoreInstance.collection('users').doc(user.currentUser.uid)
        .collection("createMilestone")
        .orderBy('timestamp', descending: true)
        .get();

    if (res.docs.isNotEmpty) {
      setState(() {
        targetedDays = res.docs.last.data()['days'];
        date = res.docs.last.data()['date'];
      });
      check = true;
    } else {
      setState(() {
        targetedDays = '0';
        date = '0';
      });
      check = true;
    }
  }

  Future<void> showDialogCreateNewMilestone(context) async {
    var date;
    TextEditingController _days = TextEditingController();
    bool _validate = false;

    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Create New Milestone'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _days,
                  autofillHints: ['0', '5', '10'],
                  decoration: InputDecoration(
                    labelText: 'Current progress (%)',
                    errorText: _validate ? 'Value Can\'t Be Empty' : null,
                  ),
                ),
                DateTimePicker(
                  cursorColor: blue,
                  initialValue: '',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  dateLabelText: 'Target Completion Date',
                  onChanged: (val) => date = val,
                  validator: (val) {
                    date = val;
                    return null;
                  },
                  onSaved: (val) => date = val,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Create', style: TextStyle(color: blue),),
              onPressed: () {
                setState(() {
                  firebaseFirestore.collection('users').doc(user.currentUser.uid).collection('createMilestone').add({
                    'date': date,
                    'days': _days.text,
                    'timestamp': DateTime.now().microsecondsSinceEpoch,
                  });
                });
                Navigator.of(context).pop();
                //CustomPopupBox().showMyDialog(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Milestone',
              style: TextStyle(fontSize: 18,),
            ),
            SizedBox(
              height: 8,
            ),
            Divider(
              height: 1.5,
              color: Color.fromARGB(255, 224, 224, 224),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1% Completed',
                      style: TextStyle(fontSize: 10),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('180 days left in this project'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Target Completation date',
                      style: TextStyle(fontSize: 10),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Feather.edit_2,
                          size: 15,
                          color: blue,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Oct 16, 2025'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            LinearPercentIndicator(
              lineHeight: 10.0,
              percent: 0.01,
              backgroundColor: Color.fromARGB(255, 233, 233, 233),
              progressColor: blue,
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 1.5,
              color: Color.fromARGB(255, 224, 224, 224),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                showDialogCreateNewMilestone(context);
              },
              child: Text(
                'Create new milestones',
                style: TextStyle(fontSize: 15, color: blue),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(255, 235, 235, 235),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(4)),
    );
  }
}
